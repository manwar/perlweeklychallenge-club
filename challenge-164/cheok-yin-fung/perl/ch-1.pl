map {  print "$_\n" if (1 x $_) !~ /^1?$|^(11+?)\1+$/ && $_ eq scalar reverse $_ } 1..1000

# using Abigail's regex to test for prime numbers

