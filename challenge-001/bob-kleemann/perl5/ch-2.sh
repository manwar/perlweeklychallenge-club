perl -E 'say for map { $_ % 15 ? $_ % 5 ? $_ % 3 ? $_ : "fizz" : "buzz" : "fizz buzz" } 1..20'
