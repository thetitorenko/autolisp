;: Скрипт для увеличиния значения атрибута блока
(defun c:incrementor ()

  ;выбор и преобразование ename в VLA-объект
  (setq blk (vlax-ename->vla-object (car (entsel "\n Выберите блок:"))))
  
  ;вывод имени выбранного блока
  (prompt "\n Выбран блок с именем: ")
  (princ (vla-get-effectivename blk))
  
  ;ввод названия атрибута для изменения
  (setq tag_name (getstring "\n Введите название атрибута: "))
  
  ;ввод начального значения (она же вторая часть нового атрибута)
  (initget (+ 1 2 4)) ;проверка ввода
  (setq new_tag_2 (getint "\n Введите начальное значение: "))

  ;считываение значения атрибута в блоке
  (setq old_tag (vl-getattributevalue blk tag_name))
  (print old_tag) ;debug
  
  ;поиск индекса "точки" с конца
  (setq ndx (vl-string-position (ascii ".") old_tag nil T))
  (setq ndx (+ ndx 1))
  (print ndx) ;debug
  
  ;обрезка значения атрибута блока до точки
  (setq new_tag_1 (substr init_tag 1 ndx))
  (print new_tag_1)
  
  ;конкатинация обрезаного значения и введенного начального
  ;значения атрибута
  (setq new_tag (strcat new_tag_1 (itoa new_tag_2)))
  (print new_tag) ;debug
  
  ;задание нового значения блока
  (vl-setattributevalue blk tag_name new_tag)
  
  (princ)
)


;; Получение значения атрибута блока 
;; Автор Lee Mac
;; http://www.lee-mac.com/attributefunctions.html
(defun vl-getattributevalue ( blk tag )
    (setq tag (strcase tag))
    (vl-some '(lambda ( att ) (if (= tag (strcase (vla-get-tagstring att))) (vla-get-textstring att))) (vlax-invoke blk 'getattributes))
)


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