(setq leap '(31 29 31 30 31 30 31 31 30 31 30 31))
(setq nonleap '(31 28 31 30 31 30 31 31 30 31 30 31))



(de which_day (X)
(let (formatted (mapcar format (mapcar pack (split (chop X) "-")))
    year (car formatted)
    month  (cadr formatted)
    day  (caddr formatted)
    )
    (if (or (= 0 (% year 400)) (and (= 0 (% year 4) (not (= 0 (% year 100))) )))
        (prinl (+ (apply + (head (- month 1) leap)) day) )
        (prinl (+ (apply + (head (- month 1) nonleap)) day) )
    )
)
)

(which_day "2025-02-02")
(which_day "2025-04-10")
(which_day "2025-09-07")