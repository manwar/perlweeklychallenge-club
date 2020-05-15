use 5.30.0;
use warnings;

use List::Util qw(sum);
use Algorithm::Combinatorics qw(combinations);

sub helper {
    my ( $a, $b ) = @_;
    sum( split //, sprintf ("%b", $a ^ $b ));
}

sub bitsum {
    sum map {helper @$_} combinations \@ARGV, 2
}

print bitsum;
