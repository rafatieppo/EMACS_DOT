;; The content below was taken at
;; http://batsov.com/articles/2012/02/19/package-management-in-emacs-the-good-the-bad-and-the-ugly/

;; I only replace the package list. For more and more files, visit
;; https://github.com/bbatsov/prelude/blob/master/core/prelude-packages.el

(defvar prelude-packages
  '(ace-jump-mode
    ac-math
    auctex
    auto-complete
    elpy
    ess
    ess-R-data-view
    ess-R-object-popup
    flx
    flx-ido
    flycheck
    highlight-symbol
    ido-hacks
    ido-vertical-mode
    indent-guide
    jedi
    julia-mode
    markdown-mode
    markdown-toc
    multiple-cursors
    polymode
    popup
    powerline
    py-autopep8
    smartparens
    smex
    sr-speedbar
    yafolding
    yasnippet)
  "A list of packages to ensure are installed at launch.")

(defun prelude-packages-installed-p ()
  (loop for p in prelude-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(unless (prelude-packages-installed-p)
  ;; Check for new packages (package versions).
  (message "%s" "Emacs Prelude is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; Install the missing packages.
  (dolist (p prelude-packages)
    (when (not (package-installed-p p))
      (package-install p))))

(provide 'prelude-packages)
