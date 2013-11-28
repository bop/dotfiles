;; ===== Set the highlight current line minor mode =====
;; In every buffer, the line which contains the cursor will be fully
;; highlighted

;; (global-hl-line-mode 1)

(global-linum-mode t)

;; ========= Set colours ==========


;; Set cursor and mouse-pointer colours
(set-cursor-color "gold")
(set-mouse-color "red")

;; Set region background colour
(set-face-background 'region "sienna")

;; Set emacs background colour
;(set-background-color "white")
(set-foreground-color "#dbdbdb")
(set-background-color "#000000")

(if (> (display-color-cells) 20)
    (custom-set-faces
     '(font-lock-builtin-face ((t (:foreground "deepskyblue"))))
     '(font-lock-comment-face ((t (:foreground "gray60"))))
     '(font-lock-doc-face ((t (:foreground "darkkhaki"))))
     '(font-lock-keyword-face ((t (:foreground "magenta"))))
     '(font-lock-function-name-face ((t (:foreground "green" :background "seagreen"))))
     '(font-lock-string-face ((t (:foreground "gold"))))
     '(font-lock-type-face ((t (:foreground "cyan" :background "slateblue"))))
     '(font-lock-variable-name-face ((t (:foreground "yellow"))))
   
     '(modeline ((t (:foreground "plum1" :background "navy"))))
     '(region ((t (:background "sienna"))))
     '(highlight ((t (:foreground "black" :background "darkseagreen2"))))
     
     '(diff-added-face ((t (:foreground "green"))))
     '(diff-changed-face ((t (:foreground "yellow"))))
     '(diff-header-face ((t (:foreground "cyan"))))
     '(diff-hunk-header-face ((t (:foreground "magenta"))))
     '(diff-removed-face ((t (:foreground "khaki")))))
)

;;to display time
;;(display-time)

;;to manage the geometric size of initial window.
;;(setq initial-frame-alist '((width . 115) (height . 55)))


;;set the keybinding so that you can use f4 for goto line
(global-set-key [f4] 'goto-line)
;;set the keybinding so that f3 will start the shell
(global-set-key [f3] 'shell)
;;set the keybinding so that f5 will start query replace
(global-set-key [f5] 'query-replace)
(global-set-key [f6] 'switch-to-buffer)
(global-set-key [f7] 'hippie-expand)
(global-set-key [f8] 'ispell)

;; of course :
(require 'org-latex)
;; allow for export=>beamer by placing

;; #+LaTeX_CLASS: beamer in org files
(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))
(add-to-list 'org-export-latex-classes
  ;; beamer class, for presentations
  '("beamer"
     "\\documentclass[11pt]{beamer}\n
      \\mode<{{{beamermode}}}>\n
      \\usetheme{{{{beamertheme}}}}\n
      \\usecolortheme{{{{beamercolortheme}}}}\n
      \\beamertemplateballitem\n
      \\setbeameroption{show notes}
      \\usepackage[utf8]{inputenc}\n
      \\usepackage[T1]{fontenc}\n
      \\usepackage{hyperref}\n
      \\usepackage{color}
      \\usepackage{listings}
      \\lstset{numbers=none,language=[ISO]C++,tabsize=4,
  frame=single,
  basicstyle=\\small,
  showspaces=false,showstringspaces=false,
  showtabs=false,
  keywordstyle=\\color{blue}\\bfseries,
  commentstyle=\\color{red},
  }\n
      \\usepackage{verbatim}\n
      \\institute{{{{beamerinstitute}}}}\n          
       \\subject{{{{beamersubject}}}}\n"

     ("\\section{%s}" . "\\section*{%s}")
     
     ("\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}"
       "\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}")))

  ;; letter class, for formal letters

  (add-to-list 'org-export-latex-classes

  '("letter"
     "\\documentclass[11pt]{letter}\n
      \\usepackage[utf8]{inputenc}\n
      \\usepackage[T1]{fontenc}\n
      \\usepackage{color}"
     
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\paragraph{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


;;html-helper mode
 ;;; config html-helper-mode
 (autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
 (setq html-helper-do-write-file-hooks t
        html-helper-build-new-buffer t)
 (add-hook 'html-helper-load-hook '(lambda () (require 'html-font)))
 (add-hook 'html-helper-mode-hook '(lambda () (font-lock-mode 1)))

;; (setcdr (assoc "\\.s?html?\\'" auto-mode-alist) 'html-helper-mode)
  (require 'font-lock)
  (global-font-lock-mode 't)
  (setq font-lock-maximum-decoration 't
     font-lock-background-mode 'dark)  ; ou "light", selon couleur de fond
  (setq font-lock-face-attributes
     '((font-lock-comment-face "Red4")
     (font-lock-string-face "Green4")
     (font-lock-keyword-face "Orange4")
     (font-lock-function-name-face "Blue4")
     (font-lock-variable-name-face "Blue2")
     (font-lock-type-face "Wheat")
     (font-lock-reference-face "VioletRed4")
     (message-cited-text-face "Blue1")
     (message-header-name-face "Green3")))

  (global-set-key (read-kbd-macro "<f12>") 'font-lock-mode)
  (global-set-key (read-kbd-macro "S-<f12>") 'show_face_on_point_name)
 ;;; end cfg html-helper-mode



;; Mode  Remember : une to-do list (M-x remember) / en conjonction avec org-mode
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)
(setq org-agenda-files (list "~/org/work.org"
                             "~/org/school.org" 
                             "~/org/home.org"))


	; dictionnaire francais pour la correction orthographique ispell
	;(setq ispell-dictionary "francais")

    ; format jour/mois/an pour le calendrier (M-x calendar)
    (setq european-calendar-style t)

    ; la semaine commence le lundi
    (setq calendar-week-start-day 1)

    ; jours et mois en francais dans le calendrier 
    (defvar calendar-day-abbrev-array
      ["dim" "lun" "mar" "mer" "jeu" "ven" "sam"])
    (defvar calendar-day-name-array
      ["dimanche" "lundi" "mardi" "mercredi" "jeudi" "vendredi" "samedi"])
    (defvar calendar-month-abbrev-array
      ["jan" "fév" "mar" "avr" "mai" "jun"
       "jul" "aou" "sep" "oct" "nov" "déc"])
    (defvar calendar-month-name-array
      ["janvier" "février" "mars" "avril" "mai" "juin"
       "juillet" "aout" "septembre" "octobre" "novembre" "décembre"])

;; Suite optionnelle étant donné que tout semble déjà en ordre ...

;;(require 'color-theme)
;;(require 'deft)

(add-to-list 'load-path "/home/bossip/.emacs.d/")

(load "~/.emacs.d/nxhtml/autostart.el")
(setq mumamo-background-colors nil) 
(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mumamo-mode))


(add-to-list 'load-path
              "~/.emacs.d/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.


(setq tramp-syntax 'url)
(require 'tramp)
(setq tramp-default-method "ssh")
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(diff-added-face ((t (:foreground "green"))))
 '(diff-changed-face ((t (:foreground "yellow"))))
 '(diff-header-face ((t (:foreground "cyan"))))
 '(diff-hunk-header-face ((t (:foreground "magenta"))))
 '(diff-removed-face ((t (:foreground "khaki"))))
 '(font-lock-builtin-face ((t (:foreground "deepskyblue"))))
 '(font-lock-comment-face ((t (:foreground "gray60"))))
 '(font-lock-doc-face ((t (:foreground "darkkhaki"))))
 '(font-lock-function-name-face ((t (:foreground "green" :background "seagreen"))))
 '(font-lock-keyword-face ((t (:foreground "magenta"))))
 '(font-lock-string-face ((t (:foreground "gold"))))
 '(font-lock-type-face ((t (:foreground "cyan" :background "slateblue"))))
 '(font-lock-variable-name-face ((t (:foreground "yellow"))))
 '(highlight ((t (:foreground "black" :background "darkseagreen2"))))
 '(mode-line ((t (:foreground "plum1" :background "navy"))))
 '(region ((t (:background "sienna")))))



;; French conjugator: (app-dicts/verbiste)
   (defun tsi-french-conjugator (word)
     "Call french-conjugator on WORD."
     (interactive "sWord to conjugate in French: ")
     (save-excursion
       (let ((old-buffer (current-buffer)))
         (get-buffer-create "*tsi-french-conjugator*")
         (set-buffer "*tsi-french-conjugator*")
         (erase-buffer)
         (set-buffer old-buffer))
       (call-process "french-conjugator" nil "*tsi-french-conjugator*" t word)
       (display-buffer "*tsi-french-conjugator*")))
   (global-set-key "\C-cf" 'tsi-french-conjugator)


;; spelling checker: (app-text/aspell, app-dicts/aspell-en, app-dicts/aspell-fr)
   (setq ispell-program-name "aspell")


 ;; calendar and diary:
   (setq diary-file "~/.diary")
   (setq mark-holidays-in-calendar t)
   (setq mark-diary-entries-in-calendar t)
   (setq calendar-latitude 46.20) ;; 46n12, see <URL:http://www.astro.ch/>
   (setq calendar-longitude 6.15) ;; 06e09, see <URL:http://www.astro.ch/>
   (setq calendar-location-name "Geneva, CH")
   (add-hook 'diary-display-hook 'fancy-diary-display)
   (setq diary-schedule-interval-time 60)
   (add-hook 'list-diary-entries-hook 'include-other-diary-files)
   (add-hook 'mark-diary-entries-hook 'mark-included-diary-files)
   (add-hook 'diary-hook 'appt-make-list)

;; vcsh


;; edition ipython Notebook
(defvar server-buffer-clients)
(when (and (fboundp 'server-start) (string-equal (getenv "TERM") 'xterm))
  (server-start)
  (defun fp-kill-server-with-buffer-routine ()
    (and server-buffer-clients (server-done)))
  (add-hook 'kill-buffer-hook 'fp-kill-server-with-buffer-routine))


(setq py-python-command-args '("--matplotlib" "--colors" "LightBG"))

(setq ansi-color-for-comint-mode t)



(setq
 python-shell-interpreter "ipython"
 python-shell-interpreter-args ""
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code
   "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code
   "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code
   "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")