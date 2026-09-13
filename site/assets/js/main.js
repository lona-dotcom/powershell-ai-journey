const menuButton = document.querySelector('.menu-toggle');
const navigation = document.querySelector('.nav-list');
const navbar = document.querySelector('.navbar');

const themeToggle = document.createElement('button');
themeToggle.className = 'theme-toggle';
themeToggle.type = 'button';
themeToggle.setAttribute('aria-pressed', 'false');

const themeLanguage = document.documentElement.lang || 'fr';
const themeLabels = {
  fr: { light: 'Thème : Clair', dark: 'Thème : Sombre', toLight: 'Activer le thème clair', toDark: 'Activer le thème sombre' },
  de: { light: 'Thema: Hell', dark: 'Thema: Dunkel', toLight: 'Helles Thema aktivieren', toDark: 'Dunkles Thema aktivieren' },
  en: { light: 'Theme: Light', dark: 'Theme: Dark', toLight: 'Enable light theme', toDark: 'Enable dark theme' }
};
const currentThemeLabels = themeLabels[themeLanguage] || themeLabels.fr;

const savedTheme = localStorage.getItem('theme');
const systemPrefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
const initialTheme = savedTheme || (systemPrefersDark ? 'dark' : 'light');

const applyTheme = (theme) => {
  const isDark = theme === 'dark';
  document.documentElement.toggleAttribute('data-theme', isDark);
  if (isDark) document.documentElement.setAttribute('data-theme', 'dark');
  themeToggle.textContent = isDark ? currentThemeLabels.dark : currentThemeLabels.light;
  themeToggle.setAttribute('aria-label', isDark ? currentThemeLabels.toLight : currentThemeLabels.toDark);
  themeToggle.setAttribute('aria-pressed', String(isDark));
};

if (navbar) {
  navbar.insertBefore(themeToggle, menuButton || navigation);
  applyTheme(initialTheme);
  themeToggle.addEventListener('click', () => {
    const nextTheme = document.documentElement.dataset.theme === 'dark' ? 'light' : 'dark';
    localStorage.setItem('theme', nextTheme);
    applyTheme(nextTheme);
  });
}

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

// Initialisation des icônes Lucide si la bibliothèque est chargée
if (typeof lucide !== 'undefined' && lucide.createIcons) {
  lucide.createIcons();
}

// Animation d'apparition au scroll (fade-in)
if ('IntersectionObserver' in window) {
  const scrollObserver = new IntersectionObserver(
    (entries, observer) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add('is-visible');
          observer.unobserve(entry.target);
        }
      });
    },
    { threshold: 0.15 }
  );

  document.querySelectorAll('.fade-in-scroll').forEach((element) => {
    scrollObserver.observe(element);
  });
} else {
  // Fallback si pas de support IntersectionObserver
  document.querySelectorAll('.fade-in-scroll').forEach((element) => {
    element.classList.add('is-visible');
  });
}
