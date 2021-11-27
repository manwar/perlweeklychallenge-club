perl -se '($a, $b) = split(/,/, sprintf("%d,%d", eval("0b$a"), eval("0b$b")));     printf("%b", $a+$b);' -- -a=10 -b=11
