(defun c:testbean ()
  
  ;***************************************
  ;Save system variables
  (setq oldsnap (getvar "osmode")) ;save snap settings
  (setq oldblipmode (getvar "blipmode")) ;save blipmode setting
  
  ;Swith off system variables
  (setvar "osmode" 0) ;switch off snap
  (setvar "blipmode" 0) ;swith off blipmode

  ;***************************************
  ;Get user inputs
  ;1 = Disallows the user from pressing "Enter".
	;2 = Disallows the user from entering "Zero".
	;4 = Disallows the user from entering a "Negative Number".
  (initget (+ 1 2 4)) ;check user input
  (setq lb (getdist "\nLenght of Beam: "))
  (initget (+ 1 2 4))
  (setq hb (getdist "\nHeight of Beam: "))
  (initget (+ 1 2 4))
  (setq wt (getdist "\nFlange Thickness: "))
  (initget (+ 1 2 4))
  (setq ep (getdist "\nEnd Plate Thickness: "))
  (initget (+ 1 2 4))
  (setq nl (getdist "\nLenght of Notch"))
  (initget (+ 1 2 4))
  (setq nd (getdist "\nDepth of Notch:"))
  
  ;***************************************
  ;Get insertion point
  (setvar "osmode" 32) ;switch on snap
  (while
    ;start of while loop
    (setq ip (getpoint "\nInsertion Point: ")) ;get the insertion point
    (setvar "osmode" 0) ;switch off snap
    
    ;***************************************
    ;Start of polar calculations
    (setq p2  (polar ip (dtr 180.0) (- (/ lb 2) nl)))
    (setq p3  (polar p2 (dtr 270.0) wt))
    (setq p4  (polar p2 (dtr 270.0) nd))
    (setq p5  (polar p4 (dtr 180.0) nl))
    (setq p6  (polar p5 (dtr 180.0) ep))
    (setq p7  (polar p6 (dtr 270.0) (- hb nd)))
    (setq p8  (polar p7 (dtr 0.0) ep))
    (setq p9  (polar p8 (dtr 90.0) wt))
    (setq p10 (polar p9 (dtr 0.0) lb))
    (setq p11 (polar p8 (dtr 0.0) lb))
    (setq p12 (polar p11 (dtr 0.0) ep))
    (setq p13 (polar p12 (dtr 90.0) (- hb nd)))
    (setq p14 (polar p13 (dtr 180.0) ep))
    (setq p15 (polar p14 (dtr 180.0) nl))
    (setq p16 (polar p15 (dtr 90.0) (- nd wt)))
    (setq p17 (polar p16 (dtr 90.0) wt))

    ;***************************************
    ;Start of command function
    (command "Line" ip p2 p4 p6 p7 p12 p13 p15 p17 "c"
      "Line" p3 p16 ""
      "Line" p9 p10 ""
      "Line" p5 p8 ""
      "Line" p11 p14 ""
    )
  
    (setvar "osmode" 32) ;swith on snap
  )
  
  ;***************************************
  ;Reset System Variable
  (setvar "osmode" oldsnap) ;reset snap
  (setvar "blipmode" oldblipmode) ;reset blipmode
  
  (princ) ;finish cleanly
) ;end of while loop


(defun dtr (x)
  ;define degress to radians function
  
  (* pi (/ x 180.0))
  ;devide the angle by 180 then
  ;mutiply the result by the constant PI
)

(princ)	;load cleanly