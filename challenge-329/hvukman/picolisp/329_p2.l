(setq inp "YaaAho")



(de do_it (X)
   (pack (let str_list (chop X)
    (make
    (for N  (chop X)
        (if (and (member (uppc N) (chop X)) (member (lowc N) (chop X) ) ) 
            (link N )
        )  
    )
    )
    )
   )
)

(prinl (do_it inp))
(prinl (do_it "cC"))
(prinl (do_it "A"))

# (load "perlpico/329_p2.l")
