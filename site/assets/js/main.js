const menuButton = document.querySelector('.menu-toggle');
const navigation = document.querySelector('.nav-list');

const languageLinks = {
  fr: {
    label: 'Sélecteur de langue',
    paths: { fr: 'fr', de: 'de', en: 'en' }
  },
  de: {
    label: 'Sprachauswahl',
    paths: { fr: 'fr', de: 'de', en: 'en' }
  },
  en: {
    label: 'Language selector',
    paths: { fr: 'fr', de: 'de', en: 'en' }
  }
};

const currentLanguage = document.documentElement.lang || 'fr';
const languageConfig = languageLinks[currentLanguage] || languageLinks.fr;
const currentPath = window.location.pathname;
const pageName = currentPath.split('/').pop() || 'index.html';
const legalPageMap = {
  'mentions-legales.html': { fr: 'mentions-legales.html', de: 'impressum.html', en: 'legal-notice.html' },
  'impressum.html': { fr: 'mentions-legales.html', de: 'impressum.html', en: 'legal-notice.html' },
  'legal-notice.html': { fr: 'mentions-legales.html', de: 'impressum.html', en: 'legal-notice.html' },
  'politique-confidentialite.html': { fr: 'politique-confidentialite.html', de: 'datenschutz.html', en: 'privacy-policy.html' },
  'datenschutz.html': { fr: 'politique-confidentialite.html', de: 'datenschutz.html', en: 'privacy-policy.html' },
  'privacy-policy.html': { fr: 'politique-confidentialite.html', de: 'datenschutz.html', en: 'privacy-policy.html' }
};
const localizedPageName = legalPageMap[pageName] || { fr: pageName, de: pageName, en: pageName };

if (navigation && !navigation.querySelector('.language-switcher')) {
  const languageSwitcher = document.createElement('li');
  languageSwitcher.className = 'language-switcher';
  languageSwitcher.setAttribute('aria-label', languageConfig.label);
  languageSwitcher.innerHTML = `<span class="language-label">${languageConfig.label}</span><ul class="language-list" aria-label="${languageConfig.label}">${Object.entries(languageConfig.paths).map(([language, directory]) => {
    const target = localizedPageName[language];
    const href = target === 'index.html' ? `../${directory}/` : `../${directory}/${target}`;
    const current = language === currentLanguage ? ' aria-current="true"' : '';
    return `<li><a href="${href}" lang="${language}"${current}>${language.toUpperCase()}</a></li>`;
  }).join('')}</ul>`;
  navigation.appendChild(languageSwitcher);
}

if (menuButton && navigation) {
  menuButton.addEventListener('click', () => {
    const isOpen = navigation.classList.toggle('is-open');
    menuButton.setAttribute('aria-expanded', String(isOpen));

    if (isOpen) {
      const firstLink = navigation.querySelector('a');
      if (firstLink) firstLink.focus();
    } else {
      menuButton.focus();
    }
  });

  navigation.addEventListener('keydown', (event) => {
    if (event.key === 'Escape' && navigation.classList.contains('is-open')) {
      navigation.classList.remove('is-open');
      menuButton.setAttribute('aria-expanded', 'false');
      menuButton.focus();
    }
  });
}

const year = document.querySelector('[data-current-year]');
if (year) year.textContent = new Date().getFullYear();

function initLucideIcons() {
  if (typeof lucide !== 'undefined') {
    lucide.createIcons();
  }
}

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initLucideIcons);
} else {
  initLucideIcons();
}

