;: Скрипт для увеличиния значения атрибута блока
(defun c:incrementor ()

  ;выбор и преобразование ename в VLA-объект
  (setq blk (vlax-ename->vla-object (car (entsel "\n Выберите блок:"))))
  
  ;вывод имени выбранного блока
  (prompt "\n Выбран блок с именем: ")
  (princ (vla-get-effectivename blk))
  
  ;ввод названия атрибута для изменения
  (setq tag (getstring "\n Введите название атрибута: ")) 
  
  ;ввод начального значения
  (initget (+ 1 2 4)) ;проверка ввода
  (setq init_value (getint "\n Введите начальное значение: "))

  ;считываение значения атрибута в блоке
  (setq tag (vl-getattributevalue  blk tag ))
  (print tag) ;debug
  
  (princ)
)


;; Get Attribute Value  -  Lee Mac 
(defun LM:vl-getattributevalue ( blk tag )
    (setq tag (strcase tag))
    (vl-some '(lambda ( att ) (if (= tag (strcase (vla-get-tagstring att))) (vla-get-textstring att))) (vlax-invoke blk 'getattributes))
)


(princ)