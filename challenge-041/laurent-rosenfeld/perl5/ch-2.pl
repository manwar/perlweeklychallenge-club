use strict;
use warnings;
use feature qw /say/;

my @leonardo = (1, 1);
for my $i (1..18) {
    push @leonardo, $leonardo[-1] + $leonardo[-2] + 1;
}
say "@leonardo";
