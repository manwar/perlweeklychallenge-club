perl6 -e 'for 1..50 -> $num { my $sum = [+] $num.comb; say $num if $num %% $sum}'
