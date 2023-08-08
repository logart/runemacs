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

;; turn on line numbers
(column-number-mode)
(global-display-line-numbers-mode t)

;;disable line numbers for some modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

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

;;to make icon work you need to run
;;M-x all-the-icons-install-fonts
(use-package all-the-icons)

;;tweak bottom info bar to look nicer
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package doom-themes)

;;load better theme
(load-theme 'doom-ir-black t)

;;make brackets more rainbowish to see better corresponding bracket
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;;show help on keybinding
(use-package which-key
     :init (which-key-mode)
     :diminish which-key-mode
     :config (setq which-key-idle-delay 0.3))

;;show info on command available under M-x
(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))
