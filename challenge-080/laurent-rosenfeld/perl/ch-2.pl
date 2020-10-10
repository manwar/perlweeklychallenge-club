use strict;
use warnings;
use feature qw /say/;

my @n = ([1, 2, 2], [1, 4, 3, 2], [qw<3 1 5 8 7 4 2>]);
for my $num_ref (@n) {
    my $count = scalar @$num_ref;
    for my $i (0..$#$num_ref) {
        for my $j (-1, 1) {
            next if $i + $j < 0;  # avoid negative subscripts
            $count++ if (defined $num_ref->[$i+$j]) and
                $num_ref->[$i] > $num_ref->[$i+$j];
        }
    }
    say "Total candies required for [@$num_ref]: $count.";
}
