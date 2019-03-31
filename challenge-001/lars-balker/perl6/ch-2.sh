perl6 -e 'say ($_%3 ?? "" !! "fizz ") ~ ($_%5 ?? "" !! "buzz") || $_ for 1..20'

