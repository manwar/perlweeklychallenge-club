perl6 -e 'for 1 .. 20 {say $_ % 15 ?? $_ % 5 ?? $_ % 3 ?? $_ !! "fizz" !! "buzz" !! "fizzbuzz" };'
