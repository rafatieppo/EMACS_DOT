--- 
title: Guide to install and configure EMACS packs 
author: Rafael Tieppo 
date: 2021 
--- 

# cpp

install from melpa:
`irony`
`company-irony`

`sudo apt-get install clang cmake libclang`

Into `.emacs`

```
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
```

open emacs `alt x`
irony-install-server 


# Python

## Auto complete and Company 

Historic

- 2020

Anaconda

- 2019-02-18

;; ANACONDA
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-eldoc-mode)


It was the best. If emacs prints a big df, elpy-mode get slow. Thus I changed to Anaconda 

- 20190130

```
(elpy-enable)
;;(setf elpy:complete-on-dot t)
;;(company-quickhelp-mode 1) ;; faz aparecer quickhelp
(add-hook 'elpy-mode-hook
          (lambda ()
            (delq 'ac-source-dictionary ac-sources)
            (delq 'ac-source-abbrev ac-sources)
            (delq 'ac-source-words-in-same-mode-buffers ac-sources)))
```

I tried several way to set up EMACS for `Pyhton`. Keeping a historic
about it was the best way to not be lost, as follows:

- 20190123
    - after several test I decided to work with `auto-complete` and
    `elpy`.
    - strengths: good speed; the help to fill the functions is more
    complete than `company` and `jedi`; it works to complete text as
    well. 
    - weakness: some times gets slow; there is no quick help balloon;
    - code:

```
    ;; auto-complete
    (elpy-enable)
    ;(add-hook 'python-mode-hook 'jedi:setup) ;; load auto-complete and pop up
    ;(setf jedi:complete-on-dot t)
    (setf elpy:complete-on-dot t)
    ;(company-quickhelp-mode 1) ;; faz aparecer quickhelp
     
    ;(add-hook 'python-mode-hook
    ;          (lambda ()
    ;            (delq 'ac-source-dictionary ac-sources)
    ;            (delq 'ac-source-abbrev ac-sources)
    ;            (delq 'ac-source-words-in-same-mode-buffers ac-sources)))
     
    (add-hook 'elpy-mode-hook
              (lambda ()
                (delq 'ac-source-dictionary ac-sources)
                (delq 'ac-source-abbrev ac-sources)
                (delq 'ac-source-words-in-same-mode-buffers ac-sources)))
```

- 20190121
    - i moved to `auto-complete` and `elpy`.

- 20181201
    - the problem with 2 auto-complete box was fixed, `(add-hook;
    'python-mode-hook 'jedi:setup)` can load *auto-complete* and *pop
    up*;
    - i choose to work only with `company-mode` and `jedi`;
    - code:

```
    ;(global-company-mode t)
    ;;(setq company-idle-delay 0)
    ;;(setq company-minimum-prefix-length 3)
    ;;company quick help use the package pos-tip to make the pop-up
    ;(company-quickhelp-mode 1)
    ;(setq company-quickhelp-delay 0)
     
    ;(defun company-jedi-setup ()
    ;  (add-to-list 'company-backends 'company-jedi))
    ;(add-hook 'python-mode-hook 'company-jedi-setup)
     
    ;(setq jedi:setup-keys t)
    ;(setq jedi:complete-on-dot t)
    ;(add-hook 'python-mode-hook 'jedi:setup)
```


- 20181001
    - working with `company-mode` and `auto-complete` (I did not know);
    - it was a messy;
    - it does not open 2 quickhelps, but opens two auto-complete;
    - it was fast;
    - the quickhelp is small, it possible to see all the help in the screen.

## Company

It is from https://cestlaz.github.io/posts/using-emacs-45-company/

- company mode

``` 
(global-company-mode t)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 3)
(global-company-mode t)

(add-to-list 'company-backends 'company-irony)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(add-hook 'irony-mode-hook #'irony-eldoc)
(add-hook 'python-mode-hook 'jedi:setup)
(defun my/python-mode-hook ())
(add-to-list 'company-backends 'company-jedi)
(add-hook 'python-mode-hook 'my/python-mode-hook)
```
## Another option

- company anaconda company-quickhelp company-anaconda)

https://www.youtube.com/watch?v=cSm3doCNyko&t=1s

## Old config

;;-----------------------------------------------------------------------------
;; option 1
;; for ANACONDA company
;(add-hook 'after-init-hook 'global-company-mode)
;(global-company-mode t)
;(setq company-minimum-prefix-lengh 1)
;(setq company-idle-delay 0)

;; COMPANY quick help
;(company-quickhelp-mode 1)
;(setq company-quickhelp-delay 0)

;; ANACONDA
;(add-hook 'python-mode-hook 'anaconda-mode)

;; company ANACONDA
;(require 'rx)
;(add-to-list 'company-backends 'company-anaconda)

;;;;;;;;;;;;;;;;;;;;;
; for ANACONDA
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-eldoc-mode)
(eval-after-load "company"
 '(add-to-list 'company-backends '(company-anaconda :with company-capf)))
(global-flycheck-mode)
(add-hook 'python-mode-hook 'flycheck-mode)
;;-----------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;
;; for ELPY - ;; Flycheck -- use flycheck not flymake with elpy
(elpy-enable)
(elpy-use-ipython)
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
;;-----------------------------------------------------------------------------
;; Jedi
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)                 ; optional
;;;;;;;;;;;;;;;;;;;;
;teste
(add-hook 'python-mode-hook 'elpy-mode)
;company jedi
(require 'rx)
(add-to-list 'company-backends 'company-jedi)
;;-----------------------------------------------------------------------------

## Autopep8 - enable autopep8 formatting on save
;(require 'py-autopep8)
;(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
;(add-hook 'anaconda-mode-hook 'py-autopep8-enable-on-save)
;(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
