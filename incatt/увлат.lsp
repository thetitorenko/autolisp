;;--------------=={ Увеличение значения атрибута блока }==--------------;;
;;                                                                      ;;
;; Cкрипт для увеличения последней цифры значения атрибута в блоке      ;;
;; на единицу.                                                          ;;
;;                                                                      ;;
;; https://github.com/thetitorenko/autolisp/tree/main/incatt            ;;
;;----------------------------------------------------------------------;;
;;  Автор:  Никита Титоренко,  https://github.com/thetitorenko          ;;
;;----------------------------------------------------------------------;;
;;  Версия 1.0    -    02-01-2020                                       ;;
;;                                                                      ;;
;;  - Первый релиз.                                                     ;;
;;----------------------------------------------------------------------;;
;;  Версия 1.1    -    07-01-2020                                       ;;
;;                                                                      ;;
;; - Добавлена проверка того, что выбранный объект является блоком.     ;;
;;----------------------------------------------------------------------;;

;; Основной скрипт
(defun c:увлат ()
  
  ;ввод названия атрибута для изменения
  (setq tag_name (getstring "\nВведите название атрибута в блоке: "))

  ;ввод начального значения (она же вторая часть нового атрибута)
  (initget (+ 1 2 4)) ;проверка ввода
  (setq new_tag_2 (getint "\nВведите начальное значение: "))
  
  ;ввод типа разделителя
  (setq sep (getstring "\nВведите символ разделителя: "))
  
  ;цикл по изменению значения атрибута блока
  (while T
  
    ;флаг, указывающий, был ли блок успешно выбран
    (setq blkSelected NIL) 
    
    ;цикл для выбора блока
    (while (not blkSelected)

      ;запрос на выбор и проверка, что выбор не равен nil
      (setq ename (entsel "\nSelect the first/next block"))
      (if ename
        (progn
          ;преобразование выбранной сущности в VLA-объект
          (setq blk (vlax-ename->vla-object (car ename)))

          ;является ли выбранный объект блоком
          (if (= (vla-get-objectname blk) "AcDbBlockReference")
            (setq blkSelected T) ;выбран правильный блок, выход из цикла
            (princ "\nThe selected object is not a block. Please select first/next block")
          )
        )
        (princ "\nNo selection made. Please select first/next block")
      )
    )
    
    ;поиск индекса "точки" с конца
    (setq ndx (vl-string-position (ascii sep) old_tag nil T))
    (setq ndx (+ ndx 1))
    
    ;слайс значения атрибута блока до точки
    (setq new_tag_1 (substr old_tag 1 ndx))
    
    ;конкатинация обрезаного значения и введенного начального
    ;значения атрибута
    (setq new_tag (strcat new_tag_1 (itoa new_tag_2)))
    
    ;задание нового значения блока
    (vl-setattributevalue blk tag_name new_tag)
    (princ "\nЗначение измененно")
    
    ;увеличеине значения
    (setq new_tag_2 (+ new_tag_2 1))
  )
  
  (princ)
)

;;----------------------------------------------------------------------;;

;; Получение значения атрибута блока 
;; Автор Lee Mac
;; http://www.lee-mac.com/attributefunctions.html
(defun vl-getattributevalue ( blk tag )
    (setq tag (strcase tag))
    (vl-some '(lambda ( att ) (if (= tag (strcase (vla-get-tagstring att))) (vla-get-textstring att))) (vlax-invoke blk 'getattributes))
)

;;----------------------------------------------------------------------;;

;; Задание значение атрибута блока 
;; Автор Lee Mac
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

;;----------------------------------------------------------------------;;
;;                            Конец скрипта                             ;;
;;----------------------------------------------------------------------;;