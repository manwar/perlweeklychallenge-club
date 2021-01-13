use 5.30.0;
use warnings;
use Algorithm::Combinatorics qw(variations_with_repetition);

sub solve {
    my ($listref, $k, $limit) = @_;
    say join ', ',
        grep /^[^0]+/ && $_ < $limit,
        map join('', @$_), variations_with_repetition ($listref, $k);
}

solve ([0, 1, 2, 5], 2, 21); 