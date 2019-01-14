(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))


;;tab width
(defun my-c-c++-mode-init ()
  (setq c-basic-offset 4)
  )
(add-hook 'c-mode-hook 'my-c-c++-mode-init)
(add-hook 'c++-mode-hook 'my-c-c++-mode-init)

;;(load-theme 'wheatgrass t)

(setq custom-theme-directory "~/.emacs.d/themes/")
(load-theme 'molokai t)

;; Color
(if window-system (progn
    (set-background-color "Black")
    (set-foreground-color "#ffffff")
    (set-cursor-color "#999999")
    (set-frame-parameter nil 'alpha 70) ;透明度
    ))


;; スクリーンの最大化
(set-frame-parameter nil 'fullscreen 'maximized)
;;(set-frame-parameter nil 'fullscreen 'fullboth)


(setq initial-frame-alist default-frame-alist )



(setq inhibit-startup-message t)
(setq initial-scratch-message nil)


;; 環境を日本語、UTF-8にする
(set-locale-environment nil)
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)


;; 対応する括弧を強調表
(show-paren-mode t)

;; C-x ; でコメントアウト
;; C-x : でコメントをはずす
(global-set-key "\C-x;" 'comment-region)
(global-set-key "\C-x:" 'uncomment-region)
(global-set-key "\C-x%" 'query-replace)

;; C-h をBackspaceに割り当て
(global-set-key "\C-h" 'delete-backward-char)
;; (makunbound 'overriding-minor-mode-map)


(require 'flymake)

(defun flymake-cc-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "g++" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))

;; C
(defun flymake-c-init ()
  (flymake-simple-make-or-generic-init
   "gcc" '("-Wall" "-Wextra" "-pedantic" "-fsyntax-only" "$CPPFLAGS")))


(push '("\\.cpp$" flymake-cc-init) flymake-allowed-file-name-masks)
(push '("\\.c$" flymake-cc-init) flymake-allowed-file-name-masks)
(push '("\\.h$" flymake-cc-init) flymake-allowed-file-name-masks)

(add-hook 'c++-mode-hook
          '(lambda ()
             (flymake-mode t)))

(add-hook 'c-mode-common-hook
          '(lambda ()
             (flymake-mode t)))


;;行番号
(global-linum-mode t)
;;menu消す
(tool-bar-mode -1)
;; ツールバーを消す
(tool-bar-mode -1)

;; スクロールは１行ごとに
(setq scroll-conservatively 1)

;; C-kで行全体を削除する
(setq kill-whole-line t)
;; 複数ウィンドウを禁止する
(setq ns-pop-up-frames nil)

;; 行の最後に来たら、新しい行を作らない
(setq next-line-add-newlines nil)

;; YaTeX
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq auto-mode-alist (append
  '(("\\.tex$" . yatex-mode)
    ("\\.ltx$" . yatex-mode)
    ("\\.cls$" . yatex-mode)
    ("\\.sty$" . yatex-mode)
    ("\\.clo$" . yatex-mode)
    ("\\.bbl$" . yatex-mode)) auto-mode-alist))

;;自動改行を抑制 これがないと長い文章のよくわからないところで改行される
(add-hook ' yatex-mode-hook
'(lambda () (auto-fill-mode -1)))


;; RefTexという参考文献とかを補完するモードをONにする 使い方がよくわかってないので調べる
(add-hook 'yatex-mode-hook
      #'(lambda ()
          (reftex-mode 1)
          (define-key reftex-mode-map
        (concat YaTeX-prefix ">") 'YaTeX-comment-region)
          (define-key reftex-mode-map
        (concat YaTeX-prefix "<") 'YaTeX-uncomment-region)
          ))
;;起動時画面
;(setq inhibit-startup-screen t)
;(split-window-horizontally)
;(other-window 1)
;; (split-window-vertically)
;(multi-term)


; load environment value
;(load-file (expand-file-name "~/.emacs.d/shellenv.el"))
;(dolist (path (reverse (split-string (getenv "PATH") ":")))
 ;(add-to-list 'exec-path path))
;(setf exec-path nil)

(require 'multi-term)

(setq multi-term-program shell-file-name)

;; emacs に認識させたいキーがある場合は、term-unbind-key-list に追加する
(add-to-list 'term-unbind-key-list "C-\\") ; IME の切り替えを有効とする
;; (add-to-list 'term-unbind-key-list "C-o")  ; IME の切り替えに C-o を設定している場合
 
;; terminal に直接通したいキーがある場合は、以下をアンコメントする
(delete "<ESC>" term-unbind-key-list)
;;(delete "C-h" term-unbind-key-list)
;;(delete "C-z" term-unbind-key-list)
;;(delete "C-c" term-unbind-key-list)
(delete "C-y" term-unbind-key-list)
(add-to-list 'term-unbind-key-list "M-x")
;; C-c m で multi-term を起動する
(global-set-key (kbd "C-c m") 'multi-term)
(define-key term-raw-map (kbd "C-h") 'term-send-backspace)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (rjsx-mode web-mode wanderlust undo-tree quickrun pdf-tools package-utils org multi-term markdown-mode flymake-cursor flycheck-pos-tip bind-key auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(term-color-black ((t (:background "black" :foreground "black"))))
 '(term-color-blue ((t (:foreground "orange"))))
 '(term-color-green ((t (:foreground "green3"))))
 '(zlc-selected-completion-face ((t (:background "dark gray" :foreground "white smoke" :slant normal :weight bold)))))



(require 'org)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;; unbind C-, to use for moving the previous buffer
(eval-after-load "org"
  '(progn
     (define-key org-mode-map (kbd "C-,") nil)))




;;
;; export
;; 
(setq org-export-latex-coding-system 'utf-8)
(setq org-export-latex-date-format "%Y-%m-%d")
(setq org-export-latex-classes nil)

(setq org-latex-classes '(("jsarticle"
                           "\\documentclass{jsarticle}
\\usepackage[dvipdfmx]{graphicx}
\\usepackage{url}
\\usepackage{atbegshi}
\\AtBeginShipoutFirst{\\special{pdf:tounicode EUC-UCS2}}
\\usepackage[dvipdfmx,setpagesize=false]{hyperref}
 [NO-DEFAULT-PACKAGES]
 [PACKAGES]
 [EXTRA]"
            ("\\section{%s}" . "\\section*{%s}")
            ("\\subsection{%s}" . "\\subsection*{%s}")
            ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
            ("\\paragraph{%s}" . "\\paragraph*{%s}")
            ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))

                          ("jsbook"
                           "\\documentclass{jsbook}
\\usepackage[dvipdfmx]{graphicx}
\\usepackage{url}
\\usepackage{atbegshi}
\\AtBeginShipoutFirst{\\special{pdf:tounicode EUC-UCS2}}
\\usepackage[dvipdfmx,setpagesize=false]{hyperref}
 [NO-DEFAULT-PACKAGES]
 [PACKAGES]
 [EXTRA]"
            ("\\chapter{%s}" . "\\chapter*{%s}")
            ("\\section{%s}" . "\\section*{%s}")
            ("\\subsection{%s}" . "\\subsection*{%s}")
            ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
            ("\\paragraph{%s}" . "\\paragraph*{%s}")
            ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))


(setq org-export-latex-packages-alist
  '(("AUTO" "inputenc"  t)
    ("T1"   "fontenc"   t)
    ))


;; latex を処理するコマンド
(setq org-latex-pdf-process
      '("~/shdir/tex2pdf %b.tex"))

;; 25.1.1
(defvar tex-compile-commands 
  '(
    ("tex2pdf %f")
    ("tex2pdf-landscape %f")))

;; 24.5.1 ??
(setq tex-compile-commands
      '(
        ("platex %b.tex && platex %b.tex && dvipdfmx %b.dvi")
        ("tex2pdf %f")))

;; 24.3.1 ??
(setq tex-compile-commands
      '(
        ("platex %r.tex && platex %r.tex && dvipdfmx %r.dvi")
        ("tex2pdf %f")))

;; load-path を追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
              (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))



;;
;; Auto Complete
;;
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'text-mode)         ;; text-modeでも自動的に有効にする
(add-to-list 'ac-modes 'fundamental-mode)  ;; fundamental-mode
(add-to-list 'ac-modes 'org-mode)
(add-to-list 'ac-modes 'yatex-mode)
(ac-set-trigger-key "TAB")
(setq ac-use-menu-map t)       ;; 補完メニュー表示時にC-n/C-pで補完候補選択
(setq ac-use-fuzzy t)          ;; 曖昧マッチ


;; ツールバーを非表示
(menu-bar-mode 0)
(scroll-bar-mode 0)


;;同様のフォント設定があればコメントアウトしておくべき
(add-to-list 'default-frame-alist '(font . "ricty-13.5"))

;;コメントアウト
(setq comment-style 'multi-line)
;; reload buffer
(global-set-key (kbd "<f5>") 'revert-buffer-no-confirm)


;; ;;
;; ;; TeX mode
;; ;;
;; (setq auto-mode-alist
;;       (append '(("\\.tex$" . latex-mode)) auto-mode-alist))
;; (setq tex-default-mode 'latex-mode)
;; (setq tex-start-commands "\\nonstopmode\\input")
;; (setq tex-run-command "ptex2pdf -u -e -ot '-synctex=1 -interaction=nonstopmode'")
;; (setq latex-run-command "ptex2pdf -u -l -ot '-synctex=1 -interaction=nonstopmode'")
;; (setq tex-bibtex-command "latexmk -e '$latex=q/uplatex %O -synctex=1 -interaction=nonstopmode %S/' -e '$bibtex=q/upbibtex %O %B/' -e '$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex %O -o %D %S/' -e '$dvipdf=q/dvipdfmx %O -o %D %S/' -norc -gg -pdfdvi")
;; (require 'tex-mode)
;; (defun tex-view ()
;;   (interactive)
;;   (tex-send-command "evince" (tex-append tex-print-file ".pdf") " &"))
;; (defun tex-print (&optional alt)
;;   (interactive "P")
;;   (if (tex-shell-running)
;;       (tex-kill-job)
;;     (tex-start-shell))
;;   (tex-send-command "evince" (tex-append tex-print-file ".pdf") " &"))
;; (setq tex-compile-commands
;;       '(("ptex2pdf -u -l -ot '-synctex=1 -interaction=nonstopmode' %f" "%f" "%r.pdf")
;;         ("uplatex -synctex=1 -interaction=nonstopmode %f && dvips -Ppdf -z -f %r.dvi | convbkmk -u > %r.ps && ps2pdf %r.ps" "%f" "%r.pdf")
;;         ("pdflatex -synctex=1 -interaction=nonstopmode %f" "%f" "%r.pdf")
;;         ("lualatex -synctex=1 -interaction=nonstopmode %f" "%f" "%r.pdf")
;;         ("luajitlatex -synctex=1 -interaction=nonstopmode %f" "%f" "%r.pdf")
;;         ("xelatex -synctex=1 -interaction=nonstopmode %f" "%f" "%r.pdf")
;;         ("latexmk %f" "%f" "%r.pdf")
;;         ("latexmk -e '$latex=q/uplatex %%O -synctex=1 -interaction=nonstopmode %%S/' -e '$bibtex=q/upbibtex %%O %%B/' -e '$biber=q/biber %%O --bblencoding=utf8 -u -U --output_safechars %%B/' -e '$makeindex=q/upmendex %%O -o %%D %%S/' -e '$dvipdf=q/dvipdfmx %%O -o %%D %%S/' -norc -gg -pdfdvi %f" "%f" "%r.pdf")
;;         ("latexmk -e '$latex=q/uplatex %%O -synctex=1 -interaction=nonstopmode %%S/' -e '$bibtex=q/upbibtex %%O %%B/' -e '$biber=q/biber %%O --bblencoding=utf8 -u -U --output_safechars %%B/' -e '$makeindex=q/upmendex %%O -o %%D %%S/' -e '$dvips=q/dvips %%O -z -f %%S | convbkmk -u > %%D/' -e '$ps2pdf=q/ps2pdf %%O %%S %%D/' -norc -gg -pdfps %f" "%f" "%r.pdf")
;;         ("latexmk -e '$pdflatex=q/pdflatex %%O -synctex=1 -interaction=nonstopmode %%S/' -e '$bibtex=q/bibtex %%O %%B/' -e '$biber=q/biber %%O --bblencoding=utf8 -u -U --output_safechars %%B/' -e '$makeindex=q/makeindex %%O -o %%D %%S/' -norc -gg -pdf %f" "%f" "%r.pdf")
;;         ("latexmk -e '$lualatex=q/lualatex %%O -synctex=1 -interaction=nonstopmode %%S/' -e '$bibtex=q/upbibtex %%O %%B/' -e '$biber=q/biber %%O --bblencoding=utf8 -u -U --output_safechars %%B/' -e '$makeindex=q/upmendex %%O -o %%D %%S/' -norc -gg -pdflua %f" "%f" "%r.pdf")
;;         ("latexmk -e '$lualatex=q/luajitlatex %%O -synctex=1 -interaction=nonstopmode %%S/' -e '$bibtex=q/upbibtex %%O %%B/' -e '$biber=q/biber %%O --bblencoding=utf8 -u -U --output_safechars %%B/' -e '$makeindex=q/upmendex %%O -o %%D %%S/' -norc -gg -pdflua %f" "%f" "%r.pdf")
;;         ("latexmk -e '$xelatex=q/xelatex %%O -synctex=1 -interaction=nonstopmode %%S/' -e '$bibtex=q/upbibtex %%O %%B/' -e '$biber=q/biber %%O --bblencoding=utf8 -u -U --output_safechars %%B/' -e '$makeindex=q/upmendex %%O -o %%D %%S/' -norc -gg -pdfxe %f" "%f" "%r.pdf")
;;         ((concat "\\doc-view" " \"" (car (split-string (format "%s" (tex-main-file)) "\\.")) ".pdf\"") "%r.pdf")
;;         ("xdg-open %r.pdf &" "%r.pdf")
;;         ("evince %r.pdf &" "%r.pdf")
;;         ("okular --unique %r.pdf &" "%r.pdf")
;;         ("zathura -x \"emacsclient --no-wait +%%{line} %%{input}\" %r.pdf &" "%r.pdf")
;;         ("qpdfview --unique %r.pdf &" "%r.pdf")
;;         ("texworks %r.pdf &" "%r.pdf")
;;         ("texstudio --pdf-viewer-only %r.pdf" "%r.pdf")
;;         ("mupdf %r.pdf &" "%r.pdf")
;;         ("firefox -new-window %r.pdf &" "%r.pdf")
;;         ("chromium --new-window %r.pdf &" "%r.pdf")))

;; (defun evince-forward-search ()
;;   (interactive)
;;   (let* ((ctf (buffer-name))
;;          (mtf (tex-main-file))
;;          (pf (concat (car (split-string mtf "\\.")) ".pdf"))
;;          (ln (format "%d" (line-number-at-pos)))
;;          (cmd "fwdevince")
;;          (args (concat "\"" pf "\" " ln " \"" ctf "\"")))
;;     (message (concat cmd " " args))
;;     (process-kill-without-query
;;      (start-process-shell-command "fwdevince" nil cmd args))))

;; (add-hook 'latex-mode-hook
;;           '(lambda ()
;;              (define-key latex-mode-map (kbd "C-c e") 'evince-forward-search)))

;; (require 'dbus)

;; (defun un-urlify (fname-or-url)
;;   "A trivial function that replaces a prefix of file:/// with just /."
;;   (if (string= (substring fname-or-url 0 8) "file:///")
;;       (substring fname-or-url 7)
;;     fname-or-url))

;; (defun evince-inverse-search (file linecol &rest ignored)
;;   (let* ((fname (decode-coding-string (url-unhex-string (un-urlify file)) 'utf-8))
;;          (buf (find-file fname))
;;          (line (car linecol))
;;          (col (cadr linecol)))
;;     (if (null buf)
;;         (message "[Synctex]: %s is not opened..." fname)
;;       (switch-to-buffer buf)
;;       (goto-line (car linecol))
;;       (unless (= col -1)
;;         (move-to-column col))
;;       (x-focus-frame (selected-frame)))))

;; (dbus-register-signal
;;  :session nil "/org/gnome/evince/Window/0"
;;  "org.gnome.evince.Window" "SyncSource"
;;  'evince-inverse-search)

;; (defun okular-forward-search ()
;;   (interactive)
;;   (let* ((ctf (buffer-file-name))
;;          (mtf (tex-main-file))
;;          (pf (concat (car (split-string mtf "\\.")) ".pdf"))
;;          (ln (format "%d" (line-number-at-pos)))
;;          (cmd "okular")
;;          (args (concat "--unique \"file:" pf "#src:" ln " " ctf "\"")))
;;     (message (concat cmd " " args))
;;     (process-kill-without-query
;;      (start-process-shell-command "okular" nil cmd args))))

;; (add-hook 'latex-mode-hook
;;           '(lambda ()
;;              (define-key latex-mode-map (kbd "C-c o") 'okular-forward-search)))

;; (defun zathura-forward-search ()
;;   (interactive)
;;   (let* ((ctf (buffer-name))
;;          (mtf (tex-main-file))
;;          (pf (concat (car (split-string mtf "\\.")) ".pdf"))
;;          (ln (format "%d" (line-number-at-pos)))
;;          (cmd "zathura")
;;          (args (concat "--synctex-forward " ln ":0:" ctf " " pf)))
;;     (message (concat cmd " " args))
;;     (process-kill-without-query
;;      (start-process-shell-command "zathura" nil cmd args))))

;; (add-hook 'latex-mode-hook
;;           '(lambda ()
;;              (define-key latex-mode-map (kbd "C-c z") 'zathura-forward-search)))

;; (defun qpdfview-forward-search ()
;;   (interactive)
;;   (let* ((ctf (buffer-name))
;;          (mtf (tex-main-file))
;;          (pf (concat (car (split-string mtf "\\.")) ".pdf"))
;;          (ln (format "%d" (line-number-at-pos)))
;;          (cmd "qpdfview")
;;          (args (concat "--unique \"" pf "#src:" ctf ":" ln ":0\"")))
;;     (message (concat cmd " " args))
;;     (process-kill-without-query
;;      (start-process-shell-command "qpdfview" nil cmd args))))

;; (add-hook 'latex-mode-hook
;;           '(lambda ()
;;              (define-key latex-mode-map (kbd "C-c q") 'qpdfview-forward-search)))

;;
;; RefTeX with TeX mode
;;
(add-hook 'latex-mode-hook 'turn-on-reftex)


;;
;; backup の保存先
;;
(setq backup-directory-alist
  (cons (cons ".*" (expand-file-name "~/.emacs.d/backup"))
        backup-directory-alist))


(setq auto-save-file-name-transforms
  `((".*", (expand-file-name "~/.emacs.d/backup/") t)))

(require 'zlc)
(zlc-mode 1)
(let ((map minibuffer-local-map))
  ;;; like menu select
  (define-key map (kbd "C-n")  'zlc-select-next-vertical)
  (define-key map (kbd "C-p")    'zlc-select-previous-vertical)
  (define-key map (kbd "C-f") 'zlc-select-next)
  (define-key map (kbd "C-b")  'zlc-select-previous)

  ;;; reset selection
  (define-key map (kbd "C-c") 'zlc-reset)
  )
(require `quickrun)
(global-set-key (kbd "C-c C-r") 'quickrun)

(global-set-key (kbd "C-x C-p") 'count-words-region)



;; (global-hl-line-mode t)

;; markdown-mode
;; m-x package-list-package, install markdown-mode | once
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
;; (setq auto-mode-alist
;;       (append '(("\\.md$" . yatex-mode)
;;                 ("\\.txt$" . yatex-mode)) auto-mode-alist))
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.txt" . markdown-mode) auto-mode-alist))

(dolist (dir (list
              "/sbin"
              "/usr/sbin"
              "/bin"
              "/usr/bin"
              "/opt/local/bin"
              "/sw/bin"
              "/usr/local/bin"
              (expand-file-name "~/bin")
              (expand-file-name "~/.emacs.d/bin")
              ))
 (when (and (file-exists-p dir) (not (member dir exec-path)))
   (setenv "PATH" (concat dir ":" (getenv "PATH")))
   (setq exec-path (append (list dir) exec-path))))
(autoload 'markdown-preview-mode "markdown-preview-mode.el" t)

(setq x-select-enable-clipboard t)
(transient-mark-mode t)


;; system-type predicates
;; from http://d.hatena.ne.jp/tomoya/20090807/1249601308
(setq darwin-p   (eq system-type 'darwin)
      linux-p    (eq system-type 'gnu/linux)
      carbon-p   (eq system-type 'mac)
      meadow-p   (featurep 'meadow))


(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))
(defun copy-from-osx ()
 (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
 (let ((process-connection-type nil))
     (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
       (process-send-string proc text)
       (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)


;; markdown-mode
;; m-x package-list-package, install markdown-mode | once
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
;; (setq auto-mode-alist
;;       (append '(("\\.md$" . yatex-mode)
;;                 ("\\.txt$" . yatex-mode)) auto-mode-alist))

(add-to-list 'auto-mode-alist '(".*\\.js\\'" . rjsx-mode))
(add-hook 'rjsx-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil) ;;インデントはタブではなくスペース
            (setq js-indent-level 2) ;;スペースは２つ、デフォルトは4
            (setq js2-strict-missing-semi-warning nil))) ;;行末のセミコロンの警告はオフ
