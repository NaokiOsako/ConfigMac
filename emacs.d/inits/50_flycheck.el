
(use-package flycheck
  :init
  (add-hook 'after-init-hook #'global-flycheck-mode)
  :config
  (progn
    (custom-set-variables
     '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages))))
