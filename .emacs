 (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                           ("marmalade" . "http://marmalade-repo.org/packages/")
                           ("melpa" . "http://melpa.milkbox.net/packages/")))

;; ========== Enable Line and Column Numbering ==========

(defun select-next-window ()
  "Switch to the next window" 
  (interactive)
  (select-window (next-window)))

(defun select-previous-window ()
  "Switch to the previous window" 
  (interactive)
  (select-window (previous-window)))

(global-set-key (kbd "M-<right>") 'select-next-window)
(global-set-key (kbd "M-<left>")  'select-previous-window)

;; ;; Show line-number in the mode line
(line-number-mode 1)

;; ;; Show column-number in the mode line
(column-number-mode 1)

;; (add-hook 'clojure-mode-hook 'paredit-mode)
;; (add-to-list 'auto-mode-alist '("\.cljs$" . clojure-mode))

;; (add-to-list 'load-path "~/bin/emacs_manual/")
;; (require 'ido)
;; (require 'less-css-mode)

;; (setq x-select-enable-clipboard t)

;; (add-to-list 'load-path "~/bin/emacs_manual/coffee-mode")
;; (require `coffee-mode)
;; (add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
;; (add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

;; (require 'column-marker)
;; ;;(add-hook 'foo-mode-hook (lambda () (interactive) (column-marker-1 80)))
;; (global-set-key [?\C-c ?m] 'column-marker-1)

;; (require 'package)
;; (package-initialize)

;; (setq package-archives '(("ELPA" . "http://tromey.com/elpa/") 
;;                           ("gnu" . "http://elpa.gnu.org/packages/")
;;                           ("marmalade" . "http://marmalade-repo.org/packages/")))

;; (setenv "PATH" (concat (getenv "PATH") ":~/.cabal/bin"))
;; (setq exec-path (append exec-path '("~/.cabal/bin")))
;; (add-to-list 'load-path "~/sb/sb/bin/ghc-mod")

;; ;; Edit .cl files as .c files
;; (setq auto-mode-alist (cons '("\.cl$" . c-mode) auto-mode-alist))

;; (show-paren-mode)

;; (setq auto-mode-alist
;;       (cons
;;        '("\\.m$" . matlab-mode)
;;        auto-mode-alist))

;; (add-to-list 'load-path "~/bin/scala-mode")
;; (require 'scala-mode-auto)

;; ;;(add-hook 'scala-mode-hook
;; ;;            '(lambda ()
;; ;;	       (scala-mode-feature-electric-mode)
;; ;;               ))

;; (load "~/bin/haskell-mode/haskell-site-file")
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;; ;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;; ;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

;; (autoload 'ghc-init "ghc" nil t)
;; (add-hook 'haskell-mode-hook (lambda () (ghc-init) (flymake-mode)))

;; ;; Load the ensime lisp code...
;; (require 'scala-mode)
;; (add-to-list 'load-path "~/bin/ensime/elisp/")
;; (require 'ensime)

;; ;; This step causes the ensime-mode to be started whenever
;; ;; scala-mode is started for a buffer. You may have to customize this step
;; ;; if you're not using the standard scala mode.
;; (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;; ;; MINI HOWTO: 
;; ;; Open .scala file. M-x ensime (once per project)
;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.

