perl -E 'say $_ % 5 == 0 ? ( $_ % 3 == 0 ? "fizzbuzz" : "buzz" ) : ($_ % 3 == 0? "fizz" : $_ ) for (1..20)'
