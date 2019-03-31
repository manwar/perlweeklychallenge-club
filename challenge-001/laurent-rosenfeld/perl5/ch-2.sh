perl -E 'say $_ % 15 ? $_ % 3 ? $_ % 5 ? $_ : "buzz" : "fizz" : "fizzbuzz" for (1..20); '
