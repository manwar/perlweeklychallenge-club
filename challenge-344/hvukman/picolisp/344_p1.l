
(de array_from_compute (X Y )
   (mapcar '((Z) (prin Z " , ")) (mapcar format (chop (format (+ (format (pack (mapcar format X))) Y )))))
   (prinl "^J")
)

(array_from_compute '(1 2 3 4) 12)
(array_from_compute '(2 7 4) 181)
(array_from_compute '(9 9 9) 1)
(array_from_compute '(1, 0, 0, 0, 0) 9999)
(array_from_compute '(0) 1000)
