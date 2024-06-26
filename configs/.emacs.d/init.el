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

;; unset key bindings
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-\\"))

(leaf zenburn-theme
  :ensure t
  :config (load-theme 'zenburn t))

;; overwrite face setting
(set-face-attribute 'default nil :background "black" :height 100)
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
(global-set-key (kbd "C-c S-<left>") 'windmove-swap-states-left)
(global-set-key (kbd "C-c S-<down>") 'windmove-swap-states-down)
(global-set-key (kbd "C-c S-<up>") 'windmove-swap-states-up)
(global-set-key (kbd "C-c S-<right>") 'windmove-swap-states-right)
;; kill current buffer
(global-set-key (kbd "C-x k") 'kill-current-buffer)
;; Display line number
(global-display-line-numbers-mode 1)
;; Complement parentheses
(electric-pair-mode 1)
;; Tab/Whitespace setting
(setq-default tab-width 4 indent-tabs-mode nil)
;; Scroll one line
(setq scroll-conservatively most-positive-fixnum)
;; Prioritize UTF-8 at coding system auto detection
(prefer-coding-system 'utf-8)
;; Set default coding system
(set-default-coding-systems 'utf-8)
;; Set coding-system user for communicationg with other x clients.
(set-selection-coding-system 'utf-8)
;; Rebinding xref-find command.
(define-key esc-map "." 'xref-find-definitions-other-window)
;; Truncate Line
(setq-default truncate-lines nil)
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))

;; ccls config
(leaf ccls
  :ensure t
  :setq
  (ccls-executable . "/usr/bin/ccls")
  (lsp-prefer-flymake . nil)
  :setq-default
  (flycheck-disabled-checkers . '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  )

;; language server
(leaf lsp-mode
  :ensure t
  :init
  (defun my/lsp-mode-setup-completion ()
    (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
          '(flex)))
  (leaf lsp-pyright
    :ensure t
    :hook
    (python-mode-hook . lsp-deferred))
  :hook
  ((c++-mode-hook c-mode-hook) . lsp-deferred)
  )

(leaf platformio-mode
  :ensure nil
  :init
  (leaf projectile :ensure t)
  (leaf async :ensure t)
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

(leaf company
  :ensure t
  :custom
  (company-idle-delay . 0)
  (company-minimum-prefix-length . 1)
  :custom-face
  (company-tooltip-selection . '((t (:box t))))
  :hook
  (prog-mode-hook . company-mode))

(leaf consult
  :ensure nil
  :el-get water-dropwort/consult
  :bind
  ("C-c g" . consult-grep)
  ("C-c l" . consult-line)
  ("C-c i" . consult-imenu)
  )

;; Existing buffers will is enabled view-mode by default at first.
(defun my/find-file-setup ()
  (when (and (buffer-file-name)
             (file-exists-p (buffer-file-name))
             (not (buffer-modified-p)))
    (view-mode)))
(add-hook 'find-file-hook 'my/find-file-setup)

;; Config for whitespace-mode
(leaf whitespace
  :require t
  :custom-face
  (whitespace-space
   . '((t (:foreground "lightgray" :background "orangered"))))
  (whitespace-trailing
   . '((t (:foreground "lightgray" :background "orangered"))))
  ((whitespace-newline whitespace-tab)
   . '((t (:foreground "lightgray" :background "gray20"))))
  :setq
  (whitespace-style
   . '(face spaces space-mark trailing
            tabs tab-mark newline newline-mark))
  (whitespace-space-regexp . "\\(\x3000+\\)")
  (whitespace-display-mappings
   . '((space-mark ?\x3000 [?\□])
       (tab-mark ?\t [?\xBB ?\t])
       (newline-mark ?\n [?↵ ?\n] [?$ ?\n])))
  :hook
  ((prog-mode-hook) . whitespace-mode)
  )

(leaf csharp-mode
  :ensure t)

(leaf desktop/tool-bar/tab-bar
  ;; Tabs are not displayed at startup.
  ;; It seems to be influenced by desktop-save,tool-bar and i3wm.
  ;; Setting these when window-setup-hook is fired appears to resolve the issue.
  :init
  (leaf tab-bar
    :require t
    :custom-face
    (tab-bar-tab
     . '((t (:foreground "black" :background "#77d9a8"))))
    (tab-bar-tab-inactive
     . '((t (:foreground "white" :background "dimgray")))))
  (leaf desktop
    :require t
    :config
    (defun my/time-subtract-days (time1 time2)
      (let ((sub-sec (time-convert (time-subtract time1 time2) 'integer)))
        (/ sub-sec 60 60 24)))
    (defvar my/emacs-start-time (current-time))
    (defun my/desktop-get-var-from-local-variables (vars varname)
      (let ((ret))
        (dolist (var vars)
          (let ((name (car var))
                (val  (cdr var)))
            (when (eq name varname)
              (setq ret val))))
        ret))
    (defun my/desktop-buffers-not-to-save-functions (filename bufname mode rest)
      (let* ((local-vars (nth 5 rest))
             (display-time (my/desktop-get-var-from-local-variables
                            local-vars 'buffer-display-time)))
        (> (my/time-subtract-days display-time my/emacs-start-time) -14)))
    (add-to-list 'desktop-modes-not-to-save 'dired-mode))
  :hook
  (window-setup-hook . (lambda ()
                         (progn
                           (desktop-save-mode t)
                           (desktop-read)
                           (tool-bar-mode -1)
                           (tab-bar-mode t)))))

(provide 'init)
