(defun c:testline ()
  (setq a (getpoint "\nChoose a Point:"))
  (setq b (getpoint "\nChoose b Point:"))
  (command "Line" a b "")
  (princ) ;finish cleanly
)

(princ) ;load cleanly