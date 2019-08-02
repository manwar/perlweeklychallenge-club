perl -E 'for my $num(1..50) { my $sum = 0; $sum += $_ for (split //, $num); say $num if $num % $sum == 0;}'
