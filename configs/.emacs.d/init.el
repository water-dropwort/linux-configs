;; <leaf-install-code>
(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))
;; </leaf-install-code>

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(leaf zenburn-theme
  :ensure t
  :config (load-theme 'zenburn t))

;; overwrite face setting
(set-face-attribute 'default nil :background "black")
(set-face-attribute 'region nil :background "#77d9a8" :foreground "black")
(set-face-attribute 'font-lock-variable-name-face nil :foreground "white")
(set-face-attribute 'font-lock-string-face nil :foreground "#f6aa00")
(set-face-attribute 'font-lock-comment-face nil :foreground "#77d9a8")
(set-face-attribute 'font-lock-comment-delimiter-face nil :foreground "#77d9a8")

(setq inhibit-startup-message t)
(setq make-backup-files nil)
(setq delete-auto-save-files t)
;; highlight parens
(show-paren-mode 1)
(setq show-paren-style 'parenthisis)
;; highlight cursor's row
(global-hl-line-mode t)
;; Keybindings to swap adjacent lines
(defun move-line (direction)
  (let ((col (current-column)))
    (unless (eq col 0)
      (move-to-column 0))
    (save-excursion
      (forward-line)
      (transpose-lines direction))
    (forward-line direction)))
(defun move-line-down ()
  (interactive)
  (move-line 1))
(defun move-line-up ()
  (interactive)
  (move-line -1))
(global-set-key (kbd "M-<down>") 'move-line-down)
(global-set-key (kbd "M-<up>") 'move-line-up)
;; Keybindings to move buffer
(global-set-key (kbd "C-c <left>") 'windmove-left)
(global-set-key (kbd "C-c <down>") 'windmove-down)
(global-set-key (kbd "C-c <up>") 'windmove-up)
(global-set-key (kbd "C-c <right>") 'windmove-right)
;; Hide toolbar
(tool-bar-mode -1)
;; Display line number
(global-display-line-numbers-mode 1)
;; Complement parentheses
(electric-pair-mode 1)
;; Tab/Whitespace setting
(setq-default tab-width 4 indent-tabs-mode nil)
;; Scroll one line
(setq scroll-conservatively 1)
;; Prioritize UTF-8 at coding system auto detection
(prefer-coding-system 'utf-8)
;; Set default coding system
(set-default-coding-systems 'utf-8)
;; Set coding-system user for communicationg with other x clients.
(set-selection-coding-system 'utf-8)

(leaf desktop
  :config (desktop-save-mode t))

;; ccls config
(leaf ccls
  :ensure t
  :setq
  (ccls-executable . "/usr/bin/ccls")
  (lsp-prefer-flymake . nil)
  :setq-default
  (flycheck-disabled-checkers . '(c/c++-clang c/c++-cppcheck c/c++-gcc)))

;; language server
(leaf lsp-mode
  :ensure t
  :custom
  `((lsp-completion-provider . :none))
  :hook ((c++-mode-hook c-mode-hook) . lsp-deferred))

(leaf platformio-mode
  :ensure nil
  :el-get water-dropwort/PlatformIO-Mode
  :config
  (add-to-list 'projectile-project-root-files "platformio.ini")
  :setq
  (path-to-platformio . "$HOME/.local/bin/platformio")
  :hook
  ((c++-mode-hook c-mode-hook) . platformio-conditionally-enable))

;; C++ mode config
(add-hook 'c++-mode-hook (lambda ()
                           (electric-indent-local-mode -1)))

(leaf vertico
  :ensure t
  :init
  (vertico-mode)
  :setq
  (vertico-cycle . t))

(leaf corfu
  :ensure t
  :custom
  `((corfu-auto . t)
    (corfu-cycle . t)
    (corfu-auto-prefix . 1)
    (corfu-auto-delay . 0))
  :hook
  (emacs-startup-hook . global-corfu-mode))

(leaf consult
  :ensure nil
  :el-get water-dropwort/consult)

(provide 'init)
