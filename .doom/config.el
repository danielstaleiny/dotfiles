;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq-default evil-shift-width 2 ;; I normally use 2wide for my projects.
              tab-width 2)

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Daniel Rafaj"
      user-mail-address "daniel.rafaj@tuta.io")

(global-auto-revert-mode t) ;; reverts buffers, TODO check if I want this.

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Noto Sans Mono" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-nord-light)
(setq doom-theme 'doom-gruvbox)
;; (setq doom-theme 'eink)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.


(map!
 :i "C-SPC" #'hippie-expand
 :i [backtab] #'+company/complete
 :v [tab] #'indent-region
 (:after company
   (:map company-active-map
     [escape]  #'company-abort
     ))
 )

(map! :leader
      "x" nil
      :desc "Comment line" ";" #'evilnc-comment-or-uncomment-lines
      :desc "Eval expression" "z" #'eval-expression
      :desc "Console Vterm" "'" #'+vterm/here
      :desc "Console Vterm small" "\"" #'+vterm/toggle
      :desc "Eshell" "e" #'+eshell/here
      :desc "Eshell small" "E" #'+eshell/toggle
      :desc "Search Project" "/" #'+default/search-project
      :desc "Search directory" "?" #'+default/search-cwd
      :desc "Kill buffer" "D" #'kill-buffer-and-window
      :desc "Last buffer" "TAB" #'evil-switch-to-windows-last-buffer
      :desc "Switch to last workspace"  "`"   #'+workspace/other
      :desc "Switch to 1st workspace"   "1"   #'+workspace/switch-to-0
      :desc "Switch to 2nd workspace"   "2"   #'+workspace/switch-to-1
      :desc "Switch to 3rd workspace"   "3"   #'+workspace/switch-to-2
      :desc "Switch to 4th workspace"   "4"   #'+workspace/switch-to-3
      ;; :desc "Switch to 5th workspace"   "5"   #'+workspace/switch-to-4
      ;; :desc "Switch to 6th workspace"   "6"   #'+workspace/switch-to-5
      ;; :desc "Switch to 7th workspace"   "7"   #'+workspace/switch-to-6
      ;; :desc "Switch to 8th workspace"   "8"   #'+workspace/switch-to-7
      ;; :desc "Switch to 9th workspace"   "9"   #'+workspace/switch-to-8
      ;; :desc "Switch to final workspace" "0"   #'+workspace/switch-to-final

      (:prefix ("g" . "git")
        :desc "Magit status" "s" #'magit-status
        :desc "Magit stage" "g" #'magit-stage
        :desc "Magit stage" "G" #'magit-stage-file
        )
      (:prefix ("b" . "buffer")
        :desc "Home Dashboard" "h" #'+doom-dashboard/open
        )
      (:prefix ("o" . "open")
        :desc "Scrach buffer" "x" #'doom/open-scratch-buffer
        )
      (:prefix ("w" . "window")
        :desc "Full window" "f" #'doom/window-maximize-buffer
        )
      (:prefix ("a" . "applications")
        :desc "Treemacs" "t" #'treemacs-select-window
        :desc "Docker" "d" #'docker
        :desc "RSS" "l" #'=rss
        :desc "Ranger" "r" #'ranger
        :desc "Deer" "d" #'deer
        :desc "IRC" "i" #'=irc
        :desc "Undo tree" "u" #'undo-tree-visualize
        )

      ;;; <leader> TAB --- workspace
      (:when (featurep! :ui workspaces)
        (:prefix ("l" . "workspace")
          :desc "Display tab bar"           "TAB" #'+workspace/display
          :desc "Switch workspace"          "."   #'+workspace/switch-to
          :desc "Switch to last workspace"  "`"   #'+workspace/other
          :desc "New workspace"             "n"   #'+workspace/new
          :desc "Load workspace from file"  "l"   #'+workspace/load
          :desc "Save workspace to file"    "s"   #'+workspace/save
          :desc "Delete session"            "x"   #'+workspace/kill-session
          :desc "Delete this workspace"     "d"   #'+workspace/delete
          :desc "Rename workspace"          "r"   #'+workspace/rename
          :desc "Restore last session"      "R"   #'+workspace/restore-last-session
          :desc "Next workspace"            "]"   #'+workspace/switch-right
          :desc "Previous workspace"        "["   #'+workspace/switch-left
          :desc "Switch to 1st workspace"   "1"   #'+workspace/switch-to-0
          :desc "Switch to 2nd workspace"   "2"   #'+workspace/switch-to-1
          :desc "Switch to 3rd workspace"   "3"   #'+workspace/switch-to-2
          :desc "Switch to 4th workspace"   "4"   #'+workspace/switch-to-3
          :desc "Switch to 5th workspace"   "5"   #'+workspace/switch-to-4
          :desc "Switch to 6th workspace"   "6"   #'+workspace/switch-to-5
          :desc "Switch to 7th workspace"   "7"   #'+workspace/switch-to-6
          :desc "Switch to 8th workspace"   "8"   #'+workspace/switch-to-7
          :desc "Switch to 9th workspace"   "9"   #'+workspace/switch-to-8
          :desc "Switch to final workspace" "0"   #'+workspace/switch-to-final))

      )


(map! (:when (featurep! :lang purescript)    ; local conditional
        (:map psc-ide-mode-map
          :localleader                  ; Use local leader
          :desc "Add import" "i" #'psc-ide-add-import
          :desc "Add clause" "a" #'psc-ide-add-clause
          :desc "Rebuild" "r" #'psc-ide-rebuild
          :desc "Case split" "s" #'psc-ide-case-split
          :desc "Load all" "l" #'psc-ide-load-all
          :desc "Definition" "g" #'+lookup/definition
          :desc "Docs" "d" #'+lookup/documentation
          :desc "Server quit" "C-q" #'psc-ide-server-quit
          :desc "Server start" "C-s" #'psc-ide-server-start
          :desc "Show type" "t" #'psc-ide-show-type
          :desc "Load module" "C-l" #'psc-ide-load-module
          :desc "Fix suggestion automatically" "f" #'psc-ide-flycheck-insert-suggestion
          :desc "Format imports, re-order them" "C-f" #'purescript-mode-format-imports
          :desc "List errors" "e" #'flycheck-list-errors
          :desc "Next error" "n" #'flycheck-next-error
          :desc "Previous error" "p" #'flycheck-previous-error

          )) ; Add which-key description
      )

(map! "C-h" (lambda!! #'evil-scroll-up))

(use-package! ranger
  :after dired
  :init (setq ranger-override-dired t)
  :config
  (unless (file-directory-p image-dired-dir)
    (make-directory image-dired-dir))

  (set-popup-rule! "^\\*ranger" :ignore t)

  (add-hook! dired-mode #'ranger-override-dired-fn)
  )

;; (map! :leader
;;      :prefix "f"
;;      "n" (lambda! (find-file "~/dotfiles/nixos/home.nix"))
;;      "N" (lambda! (find-file (concat "~/dotfiles/nixos/" (system-name) ".nix"))))
;;
;; (setq lsp-haskell-process-wrapper-function
;;   (lambda (argv)
;;     (append
;;       (append (list "nix-shell" "-I" "." "--command")
;;               (list (mapconcat 'identity argv " ")))

;;       (list (concat (lsp-haskell--get-root) "/shell.nix")))))
;;

;; ;; damn home-manager making it cabal not show up in --pure!
;; (after! dante
;;   ;; I use `nix-impure' instead of nix. I think this is because --pure won't
;;   ;; include home-manager stuff but that's how i install most of my packages
;;   (setq dante-methods-alist (delq (assoc 'nix dante-methods-alist) dante-methods-alist))
;;   (defun +haskell*restore-modified-state (orig-fn &rest args)
;;     (let ((modified-p (buffer-modified-p)))
;;       (apply orig-fn args)
;;       (when modified-p
;;         (set-buffer-modified-p t))))
;;   (advice-add #'dante-async-load-current-buffer :around #'+haskell*restore-modified-state)
;;   (setq ws-butler-global-exempt-modes
;;         (append ws-butler-global-exempt-modes '(hindent-mode))))



;; (after! web-mode
;;   (remove-hook 'web-mode-hook #'+javascript-init-lsp-or-tide-maybe-h)
;;   (add-hook 'web-mode-local-vars-hook #'+javascript-init-lsp-or-tide-maybe-h))

(setq ranger-hide-cursor t)
(setq ranger-dont-show-binary t)

(after! magit
  (magit-wip-after-save-mode t)
  (magit-wip-after-apply-mode t)

  (setq magit-save-repository-buffers 'dontask
        magit-display-file-buffer-function #'switch-to-buffer-other-window
        magithub-clone-default-directory "~/work" ;; I want my stuff to clone to ~/projects
        magithub-preferred-remote-method 'ssh_url)) ;; HTTPS cloning is awful, i authenticate with ssh keys.



(after! web-mode
  (add-hook 'web-mode-hook #'flycheck-mode)

  (setq web-mode-enable-auto-quoting nil ;; disbale adding "" after an =
        )
  (add-hook 'web-mode-hook #'add-node-modules-path)


  ;;
  ;; (setq web-mode-markup-indent-offset 2 ;; Indentation
  ;;       web-mode-code-indent-offset 2
  ;;       web-mode-enable-auto-quoting nil ;; disbale adding "" after an =
  ;;       web-mode-auto-close-style 2)
  ;; (add-hook 'web-mode-hook #'add-node-modules-path)
  ;; ;; (add-hook 'web-mode-hook #'prettier-js-mode)
  )

;; ;; Load snippets
;; ;; (after! yasnippet
;; ;;   (push (expand-file-name "snippets/" doom-private-dir) yas-snippet-dirs))
;; ;;

;; (after! :any (js-mode js2-mode)
;;   (setq js-indent-level 2
;;         js2-basic-offset )
;;   )

(after! js2-mode
  (add-hook 'js2-mode-hook #'add-node-modules-path)
  (add-hook 'js2-mode-hook #'prettier-js-mode)
  )


(after! json-mode
  (add-hook 'json-mode-hook #'add-node-modules-path)
  (add-hook 'json-mode-hook #'prettier-js-mode)
  )


(add-to-list 'auto-mode-alist '("\\.njk\\'" . web-mode))

(setq evil-escape-mode -1)
(setq company-idle-delay 1) ;; 1s
(setq global-auto-revert-mode 1)
