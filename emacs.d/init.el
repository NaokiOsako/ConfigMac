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


;; C-h をBackspaceに割り当て
(global-set-key "\C-h" 'delete-backward-char)

(setq custom-theme-directory "~/.emacs.d/themes/")
(load-theme 'molokai t)

;; ;; Color
;; (if window-system (progn
;;     (set-foreground-color "#ffffff")
;;     (set-cursor-color "#999999")
;;     (set-frame-parameter nil 'alpha 70) ;透明度
;;     ))


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

(require 'flymake)

(defun flymake-cc-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "g++-9" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))

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

;; ツールバーを非表示
(menu-bar-mode 0)
(scroll-bar-mode 0)


;;同様のフォント設定があればコメントアウトしておくべき
(add-to-list 'default-frame-alist '(font . "ricty-13.5"))

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

(global-set-key (kbd "C-x C-p") 'count-words-region)

(add-to-list 'auto-mode-alist '(".*\\.js\\'" . rjsx-mode))
(add-hook 'rjsx-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil) ;;インデントはタブではなくスペース
            (setq js-indent-level 2) ;;スペースは２つ、デフォルトは4
            (setq js2-strict-missing-semi-warning nil))) ;;行末のセミコロンの警告はオフ
(setq default-tab-width 4)
;; ""()補完
(electric-pair-mode 1)

(add-to-list 'load-path "~/.emacs.d/emmet-mode")

;==========================================
; emmet-mode (for HTML)
;==========================================
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; マークアップモードで自動的に emmet-mode をたちあげる
(add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2))) ;; indent 2 spaces
(setq emmet-move-cursor-between-quotes t) ;; 最初のクオートの中にカーソルをぶちこむ



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


(add-to-list 'load-path
              "~/.emacs.d/elpa/yasnippet")
(require 'yasnippet)
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)

;; 自分用・追加用テンプレート -> mysnippetに作成したテンプレートが格納される
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/mysnippets"
        "~/.emacs.d/snippets"
        ))

;; 既存スニペットを挿入する
(define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
;; 新規スニペットを作成するバッファを用意する
(define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
;; 既存スニペットを閲覧・編集する
(define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)

(yas-global-mode 1)

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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("045419c57614f4e0de1b7fadbcf2e0c44849e1c877a5d3e0b861ac2ab59a3507" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)
;;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)
