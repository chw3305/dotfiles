;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
 (setq user-full-name "chw_05"
       user-mail-address "casperhawy@gmail.com")


;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;;doom-dashboard

(use-package bible-gateway
  :config
  (defun doom-dashboard-widget-bible-gateway ()
    (insert "\n" (+doom-dashboard--center +doom-dashboard--width (bible-gateway-get-verse))))
  (add-hook! '+doom-dashboard-functions :append #'doom-dashboard-widget-bible-gateway))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/mac-sync/notes/")
(setq org-roam-directory (file-truename "~/mac-sync/notes/roam/"))

(setq org-roam-file-extensions '("org"))

(after! org
  (setq org-agenda-files
        (directory-files-recursively
         "~/mac-sync/notes/" "\\.org$")))

(after! org
  (setq org-agenda-span 'month))

(after! org
  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit))

(setq scroll-margin 15        ; start scrolling when cursor is 8 lines from edge
      scroll-conservatively 1000  ; never recenter suddenly
      scroll-step 1)         ; scroll line-by-line

(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)
(setq doom-font (font-spec :family "Menlo" :size 18))
;;---------------
(setq ispell-dictionary "en_GB")

(electric-indent-mode -1)

(add-hook 'text-mode-hook #'visual-fill-column-mode)
(add-hook 'org-mode-hook #'visual-fill-column-mode)

(remove-hook 'after-init-hook #'global-flycheck-mode)

(setq visual-fill-column-center-text t)

(after! org-roam
  (setq org-roam-completion-everywhere t))

(add-to-list 'load-path "~/.doom.d/lisp/")
(require 'org-superstar)

(after! org
 (add-hook 'org-mode-hook #'org-superstar-mode))

;;-----
(setq ispell-program-name "aspell")

;; get rid of top bar
;;(add-to-list 'default-frame-alist '(undecorated . t))
;;-----

(setq org-roam-capture-templates
      '(("m" "main" plain "%?"
         :if-new (file+head "main/${slug}.org"
                            "#+title: ${title}\n#+date: %U\n\nTags:\n\n* References\n\n")
         :immediate-finish t
         :unnarrowed t)
        ("r" "reference" plain "%?"
         :if-new (file+head "reference/${title}.org"
                            "#+title: ${title}\n#+date: %U\n")
         :immediate-finish t
         :unnarrowed t)
        ("t" "tags" plain "%?"
         :if-new (file+head "tags/${title}.org"
                            "#+title: ${title}\n#+date: %U\n")
         :immediate-finish t
         :unnarrowed t)
        ("i" "indexes" plain "%?"
         :if-new (file+head "indexes/>-${slug}.org"
                            "#+title: ${title}\n#+date: %U\n")
         :unnarrowed t)
        ("b" "book notes" plain "%?"
         :if-new (file+head "reference/books/${slug}.org"
                            "#+title: ${title}\n#+date: %U\n")
         :unnarrowed t)
        ("l" "lecture notes" plain "%?"
         :if-new (file+head "reference/lectures/${slug}.org"
                            "#+title: ${title}\n#+date: %U\n")
         :unnarrowed t)))
;;---

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/mac-sync/notes/roam/"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))


;; bible

(use-package! bible-gateway)




;;org roam stuff
(use-package! org-roam-ui
  :after org-roam
  :hook (org-roam-mode . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

;;-----
(use-package doom-modeline
  :ensure t
  :init
  (setq doom-modeline-time-live-icon t)
  ;; 1. Global settings that MUST load before the mode starts
  (setq doom-modeline-height 40)
  (setq doom-modeline-bar-width 4)
  (setq doom-modeline-window-width-limit 85)
  (setq doom-modeline-spc-face-overrides nil)
  (setq doom-modeline-project-detection 'auto)
(setq doom-modeline-enable-word-count t)
  ;; 2. Icons & Modals
  (setq doom-modeline-icon t)
  (setq doom-modeline-major-mode-icon t)
  (setq doom-modeline-major-mode-color-icon t)
  (setq doom-modeline-buffer-state-icon t)
  (setq doom-modeline-buffer-modification-icon t)
  (setq doom-modeline-support-imenu t)

  ;; 3. Crucial Evil/Modal State settings (The traffic light dot)
  (setq doom-modeline-modal t)
  (setq doom-modeline-modal-icon t)
  (setq doom-modeline-modal-modern-icon nil) ; <--- This creates the circle dot


  :hook (after-init . doom-modeline-mode))
;;----
;;.git thingy
(after! projectile
            (setq projectile-project-root-files-bottom-up
                  (remove ".git" projectile-project-root-files-bottom-up)))
;;
  
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
