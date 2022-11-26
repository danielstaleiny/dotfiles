;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq-default evil-shift-width 2 ;; I normally use 2wide for my projects.
              tab-width 2)

(global-auto-revert-mode t)


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Daniel Rafaj"
      user-mail-address "daniel.rafaj@tuta.io")

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
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
;;
(setq doom-font (font-spec :family "Noto Sans Mono Medium" :size 26))


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-plain)
;; (setq doom-theme 'tsdh-light)
(setq doom-theme 'doom-gruvbox)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;
;;
(map!
 :n "-" #'dired-jump
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
        ;; :desc "Treemacs" "t" #'treemacs-select-window
        :desc "Agenda" "a" #'org-agenda
        :desc "Docker" "D" #'docker
        :desc "RSS" "l" #'=rss
        :desc "Ranger" "r" #'ranger
        :desc "Deer" "d" #'deer
        :desc "IRC" "i" #'=irc
        :desc "Deft Notes" "n" #'deft
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
          :desc "add import" "i" #'psc-ide-add-import
          :desc "add clause" "a" #'psc-ide-add-clause
          :desc "rebuild" "r" #'psc-ide-rebuild
          :desc "case split" "s" #'psc-ide-case-split
          :desc "load all" "l" #'psc-ide-load-all
          :desc "definition" "g" #'+lookup/definition
          :desc "docs" "d" #'+lookup/documentation
          :desc "server quit" "C-q" #'psc-ide-server-quit
          :desc "server start" "C-s" #'psc-ide-server-start
          :desc "show type" "t" #'psc-ide-show-type
          :desc "load module" "C-l" #'psc-ide-load-module
          :desc "fix suggestion automatically" "f" #'psc-ide-flycheck-insert-suggestion
          :desc "format imports, re-order them" "C-f" #'purescript-mode-format-imports
          :desc "list errors" "e" #'flycheck-list-errors
          :desc "next error" "n" #'flycheck-next-error
          :desc "prev error" "p" #'flycheck-previous-error

          )) ; Add which-key description
      )


(map! (:when (featurep! :ui deft)    ; local conditional
        (:map deft-mode-map
          :localleader                  ; Use local leader
          :desc "create new deft note" "n" #'deft-new-file
          :desc "new file named" "RET" #'deft-new-file-named
          :desc "archive file" "a"   #'deft-archive-file
          :desc "clear filter" "c"   #'deft-filter-clear
          :desc "delete file" "d"   #'deft-delete-file
          :desc "find file" "f"   #'deft-find-file
          :desc "refresh" "g"   #'deft-refresh
          :desc "filter" "l"   #'deft-filter
          :desc "new file" "n"   #'deft-new-file
          :desc "rename file" "r"   #'deft-rename-file
          :desc "toggle desc/asc sort"  "s"   #'deft-toggle-sort-method
          :desc "toggle Fuzzy search" "t"   #'deft-toggle-incremental-search
          )) ; Add which-key description
      )



(map! (:when (featurep! :lang org)    ; local conditional
        (:map org-mode-map
          :localleader                  ; Use local leader
          :desc "org-toggle-item" "z"       #'org-toggle-item
          :desc "insert-cite" "y"           #'org-ref-insert-link
          :desc "insert-cite-Y" "Y"         #'org-ref-insert-link-hydra
          :desc "org-export-to-pdf" "C-c"   #'org-latex-export-to-pdf
          )) ; Add which-key description
      )


(map! (:when (featurep! :lang javascript)    ; local conditional
        (:map js2-mode-map
          :localleader                  ; Use local leader
          :desc "search" "S"                 #'zeal-at-point-search
          :desc "seach-at-point" "s"       #'zeal-at-point
          )) ; Add which-key description
      )


(map! (:when (featurep! :lang web)    ; local conditional
        (:map web-mode-map
          :localleader                  ; Use local leader
          :desc "search" "S"                 #'zeal-at-point-search
          :desc "seach-at-point" "s"       #'zeal-at-point
          )) ; Add which-key description
      )

(map! (:when (modulep! :tools lsp)    ; local conditional
        (:map sql-mode-map
          :localleader                  ; Use local leader
          :desc "execute query" "c"       #'lsp-sql-execute-query
          :desc "switch connection" "C-c"       #'lsp-sql-switch-connection
          )) ; Add which-key description
      )


(map! "C-h" (cmd!! #'evil-scroll-up 0))

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
  (add-hook 'web-mode-hook #'add-node-modules-path)
  (add-hook 'web-mode-hook #'prettier-js-mode)
  (setq zeal-at-point-docset "html")
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-enable-auto-quoting nil) ;; disables adding "" after an =
  (setq web-mode-auto-close-style 2)
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


(after! typescript-mode
  (add-hook 'typescript-mode-hook 'deno-fmt-mode)
  (add-hook 'typescript-mode-hook #'add-node-modules-path)
  (setq js2-strict-missing-semi-warning nil)
  (add-hook 'typescript-mode-hook #'prettier-js-mode)
  (setq zeal-at-point-docset "typescript")
  )

(after! js2-mode
  (add-hook 'js2-mode-hook 'deno-fmt-mode)
  (add-hook 'js2-mode-hook #'add-node-modules-path)
  (setq js2-strict-missing-semi-warning nil)
  (add-hook 'js2-mode-hook #'prettier-js-mode)
  (add-hook 'js2-mode-hook #'lsp)
  (add-hook 'js2-mode-hook #'direnv-update-environment)
  (setq zeal-at-point-docset "javascript")
  )

(after! sql
  (setq sql-product "postgres")
  (add-hook 'sql-mode-hook #'lsp)
  )


(after! json-mode
  (add-hook 'json-mode-hook #'add-node-modules-path)
  (add-hook 'json-mode-hook #'prettier-js-mode)
  (add-hook 'json-mode-hook #'direnv-update-environment)
  )


(after! purescript-mode
  (add-hook 'purescript-mode-hook #'add-node-modules-path)
  (add-hook 'purescript-mode-hook #'format-all-mode)
  (add-hook 'purescript-mode-hook #'direnv-update-environment)
  )


(setq org-attach-auto-tag nil)



(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.njk\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.env\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))


(after! latex-mode
  (add-hook 'latex-mode-hook #'turn-on-reftex)
  (setq reftex-plug-into-AUCTeX t)
  )


(setq-default TeX-engine 'xetex)


;; (setq! org-ref-notes-directory "")
(setq! +biblio-pdf-library-dir "~/org/papers/"
       +biblio-default-bibliography-files '("~/org/papers/library.bib")
       +biblio-notes-path "~/org/Projects/books.org")

;; (after! org-ref
;;   (setq org-ref-note-title-format
;;         "** TODO %y - %9a - %t
;;   :PROPERTIES:
;;   :Custom_ID: %k
;;   :AUTHOR: %9a
;;   :JOURNAL: %j
;;   :AVAILABILITY:
;;   :YEAR: %y
;;   :END:
;;   ")
;;   )




;; (setq bibtex-completion-bibliography
;;      '("~/aau/seminar.bib"
;;         ))

;; (setq bibtex-completion-format-citation-functions
;;   '((org-mode      . bibtex-completion-format-citation-org-link-to-PDF)
;;     (latex-mode    . bibtex-completion-format-citation-cite)
;;     (markdown-mode . bibtex-completion-format-citation-pandoc-citeproc)
;;     (default       . bibtex-completion-format-citation-default)))

;; (use-package! company-org-roam
;;       :when (featurep! :completion company)
;;       :after org-roam
;;       :config
;;       (set-company-backend! 'org-mode '(company-org-roam company-yasnippet company-dabbrev)))

(after! projectile (setq projectile-project-root-files-bottom-up (remove
            ".git" projectile-project-root-files-bottom-up)))


;; (use-package! org-ref
;;   :after org
;;   :config
;;   (setq org-latex-listings t)
;;   (add-to-list 'org-latex-packages-alist '("" "listings" nil))
;;   (setq org-latex-listings-options '(("breaklines" "true")))
;;   (setq org-ref-completion-library 'org-ref-ivy-cite)
;;   (setq org-ref-default-citation-link "autocite")
;;   (setq org-latex-pdf-process (list "latexmk -shell-escape -f -pdf %f"))
;;   )

(use-package! org-ref
  :after org
  :config
  ;; (setq org-latex-listings t)
  ;; (add-to-list 'org-latex-packages-alist '("" "listings" nil))
  ;; (setq org-latex-listings-options '(("breaklines" "true")))
  (setq org-ref-default-citation-link "autocite")
  (setq org-latex-pdf-process (list "latexmk -shell-escape -f -pdf %f"))
  (setq
   bibtex-completion-additional-search-fields '(=key=)
   bibtex-completion-display-formats
        '((t             . "${=key=:*} ${year:4} ${author:36} ${title:*}"))
        )
  )

(use-package! org-ref-ivy
  :after org-ref
  :config
  (setq org-ref-insert-link-function 'org-ref-insert-link-hydra/body
      org-ref-insert-cite-function 'org-ref-cite-insert-ivy
      org-ref-insert-label-function 'org-ref-insert-label-link
      org-ref-insert-ref-function 'org-ref-insert-ref-link
      org-ref-cite-onclick-function (lambda (_) (org-ref-citation-hydra/body)))
  )




(use-package! direnv
  :config
  (direnv-mode)
  )


;; (use-package! org-ref
;;   :after org
;;   :config
;;   (setq org-ref-completion-library 'org-ref-ivy-cite)
;;   (setq reftex-default-bibliography '("~/org/references.bib"))
;;   (setq org-ref-bibliography-notes "~/org/references-notes.org"
;;         org-ref-default-bibliography '("~/org/references.bib")
;;         org-ref-pdf-directory "~/org/bibtex-pdfs/")
;;   )
;;
;; Will only work on macos/linux
(after! counsel
  (setq counsel-rg-base-command "rg -M 240 --with-filename --no-heading --line-number --color never %s || true"))




;; doom-dashboard
(setq fancy-splash-image "~/.doom.d/splash.png")


(setq org-roam-directory "~/org/roam")

(use-package deft
  :after org
  :custom
  (deft-recursive t)
  (deft-use-filter-string-for-filename t)
  (deft-default-extension "org")
  (deft-directory "~/org/roam")
  )

(setq +latex-viewers '(zathura))
(setq vterm-shell "/run/current-system/sw/bin/zsh")


(setq evil-escape-mode -1)
(setq company-idle-delay 1) ;; 1s
;; for long lines issue
(setq-default bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)
