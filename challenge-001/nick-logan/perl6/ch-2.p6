print((join( "", (!($_ % 3) and "Fizz" or ""), (!($_ % 5) and "Buzz" or "") ) or $_), "\n") for 1..20;


