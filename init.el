;;disable menu bar
(menu-bar-mode -1)

;;Set up visible bell to blink top and bottom line when something bad happens
(setq visible-bell t)

;;improve fonts
(set-face-attribute 'default nil :font "Fira Code Retina" :height 280)

;;dark theme
(load-theme 'tango-dark)

;;make esc quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;;initialize packaging system
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			("org" . "https://orgmode.org/elpa/")
			("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;;initialize package on non linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;;this shows keypresses to easily demostrate emacs on public
(use-package command-log-mode)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

;;for whatever reason ivy does not start without this command even though it should have beenexecuted on the previous line
(ivy-mode 1)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))
