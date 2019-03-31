perl -e 'print "" . (((!($_ % 3) ? "Fizz" : "") . (!($_ % 5) ? "Buzz" : "")) || $_) . "\n" for ( 1 .. 20 );'

perl -e ‘print (((($_ % 3) && ($_ % 5)) ? $_ : ($_ % 5) ? "Fizz" : ($_ % 3) ? "Buzz" : "Fizz Buzz") . "\n") for ( 1 .. 20 );'


# ch-2.sh: 3: ch-2.sh: Syntax error: "(" unexpected
