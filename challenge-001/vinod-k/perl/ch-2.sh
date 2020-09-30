perl -le 'foreach (1..20){ if (!($_ % 15)){ print "fizzbuzz "; } elsif (!($_ % 3)){ print "fizz "; } elsif (!($_ % 5)){ print "buzz "; } else { print "$_ "; } }'
