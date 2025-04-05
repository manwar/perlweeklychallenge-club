sub rev {
    pop =~ s{ ([[:alpha:]]) (.*) ([[:alpha:]]) }
            {
 	      my($a, $b, $c) = ($1, $2, $3);
              $c . rev($b) . $a
            }reix
}

#tests:
print rev($$_[0]) eq $$_[1] ? "ok\n" : "err\n" for
[ "p-er?l"           =>  "l-re?p" ],
[ "wee-k!L-y"        =>  "yLk-e!e-w" ],
[ "_c-!h_all-en!g_e" =>  "_e-!g_nel-la!h_c" ],
