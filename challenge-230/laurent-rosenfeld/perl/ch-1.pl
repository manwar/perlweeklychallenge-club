use strict;
use warnings;
use feature qw /say/;

sub separate_digits {
    return join " ", map { split //, $_ } @_;
}

for my $test ( [<1 34 5 6>], [<1 24 51 60>] ) {
    printf "%-10s => ", "@$test";
    say separate_digits @$test;
}
