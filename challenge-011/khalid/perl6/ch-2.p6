sub identity-matrix($n) {
    my @id;
    for flat ^$n X ^$n -> $i, $j {    #0 0 , 0 1 , 0 2 , 0 3 , 0 4 etc..
        @id[$i][$j] = ($i == $j).Int; #the matrix element takes value of '1' if (i=j)
    }
    @id; 
}
say   "Rows : " ,identity-matrix(@*ARGS[0]).perl;
say "Formated Matrix : \t";
.say for identity-matrix(@*ARGS[0]).map:  "\t|" ~ * ~ '|'
