;;---------------=={ Increment Block's attribute value }==--------------;;
;; Script to increment the last digit of an attribute's value           ;;
;; in a block by one.                                                   ;;
;;----------------------------------------------------------------------;;
;;  Author:  Nikita Titorenkio, https://github.com/thetitorenko         ;;
;;----------------------------------------------------------------------;;
;;  Version 1.0    -    02-01-2020                                      ;;
;;                                                                      ;;
;;  - First release.                                                    ;;
;;----------------------------------------------------------------------;;
;;  Version 1.1    -    07-01-2020                                      ;;
;;                                                                      ;;
;; - Added checks that the selected object is a block                   ;;
;;----------------------------------------------------------------------;;

;; Main script
(defun c:incatt ()
  
  ;input for the name of the attribute to change
  (setq tag_name (getstring "\nEnter the name of the attribute in the block: "))

  ;input for initial value (also the second part of the new attribute)
  (initget (+ 1 2 4)) ;input validation
  (setq new_tag_2 (getint "\nEnter initial value: "))
  
  ;input for the type of separator
  (setq sep (getstring "\nEnter separator character: "))
  
  ;loop for changing the attribute value of the block
  (while T
    
    ; A flag to indicate whether a block has been successfully selected
    (setq blkSelected NIL) 
    
    ; Loop for block selection
    (while (not blkSelected)
      
      ;selecting and converting ename to VLA-object
      (setq blk (car (entsel "\nSelect the first/next block")))
      (setq blk (vlax-ename->vla-object blk))
    
    ;check if the selected object is a block
      (if (= (vla-get-objectname blk) "AcDbBlockReference")
        (setq blkSelected T) ; Correct block selected, exit loop
        (princ "\nThe selected object is not a block. Please select a block.")
      )
    )
    
    ;reading the attribute value in the block
    (if (vl-getattributevalue blk tag_name)
      (setq old_tag (vl-getattributevalue blk tag_name))
      (progn
        (princ "\nAttribute with the given name not found")
        (exit))
    )
    
    ;finding the index of the separator from the end
    (setq ndx (vl-string-position (ascii sep) old_tag nil T))
    (setq ndx (+ ndx 1))
    
    ;slicing the block's attribute value up to the delimiter
    (setq new_tag_1 (substr old_tag 1 ndx))
    
    ;concatenating the sliced value and the input initial 
    ;value of the attribute
    (setq new_tag (strcat new_tag_1 (itoa new_tag_2)))
    
    ;setting the new value of the block
    (vl-setattributevalue blk tag_name new_tag)
    (princ "\nValue changed")
    
    ;incrementing the value
    (setq new_tag_2 (+ new_tag_2 1))
  )
  
  (princ)
)


;; Get Attribute Value
;; Author Lee Mac
;; http://www.lee-mac.com/attributefunctions.html
(defun vl-getattributevalue ( blk tag )
    (setq tag (strcase tag))
    (vl-some '(lambda ( att ) (if (= tag (strcase (vla-get-tagstring att))) (vla-get-textstring att))) (vlax-invoke blk 'getattributes))
)


;; Set Attribute Values
;; Author Lee Mac
(defun vl-setattributevalue ( blk tag val )
    (setq tag (strcase tag))
    (vl-some
       '(lambda ( att )
            (if (= tag (strcase (vla-get-tagstring att)))
                (progn (vla-put-textstring att val) val)
            )
        )
        (vlax-invoke blk 'getattributes)
    )
)


(princ)