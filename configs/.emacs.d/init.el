(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(markdown-mode zenburn-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; activate zenburn theme
(load-theme 'zenburn t)
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
