#!/usr/bin/env perl
#niven numbers
print join "\n" ,grep {  my $sum=0; $sum += $_ for (split "", $_); ($_> 0)&&(($_ % $sum) == 0)} (0..50);
