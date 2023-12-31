; Скрипт для увеличиния значения атрибута блока

(defun c:incrementor ()
  
  (setq obj (entsel "\n Выберите блок" )) ;выбор блока
  
  (setq att_name (getstring "\n Введите название атрибута: ")) ;название атрибута
  
  (initget (+ 1 2 4)) ;проверка ввода
  (setq init_value (getint "\n Введите начальное значение: "))

  
)