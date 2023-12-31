(defun c:testbean ()

  ;***************************************
  ;Get user inputs
  (setq lb (getdist "\nLenght of Beam: "))
  (setq hb (getdist "\nHeight of Beam: "))
  (setq wt (getdist "\nFlange Thickness: "))
  (setq ep (getdist "\nEnd Plate Thickness: "))
  (setq nl (getdist "\nLenght of Notch"))
  (setq nd (getdist "\nDepth of Notch:"))
  
  ;***************************************
  ;Get insertion point
  (setq ip (getpoint "\nInsertion Point: "))
  
  ;***************************************
  ;Start of polar calculations
  (setq p2 (polar ip (dtr 180.0) (- (/ lb 2) nl)))
  (setq p3 (polar p2 (dtr 270.0) wt))
  (setq p4 (polar p2 (dtr 270.0) nd))
  (setq p5 (polar p4 (dtr 180.0) nl))
  (setq p6 (polar p5 (dtr 180.0) ep))
  (setq p7 (polar p6 (dtr 270.0) (- nd hb))
  (setq p8 (polar p7 (dtr 0.0) ep))
  (setq p9 (poler p8 (dtr 90.0) wt))
  
        
  (princ) ;finish cleanly
)


(defun dtr ()
  ;define degress to radians function
  
  (* pi (/ x 180.0))
  ;devide the angle by 180 then
  ;mutiply the result by the constant PI
)

(princ)	;load cleanly