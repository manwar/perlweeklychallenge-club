use strict;
use warnings;
use feature 'say';


sub equal_pairs {
    my %histo;
    my $pairs;
    $histo{$_}++ for @_;  # histogram to store frequencies
    for my $key (keys %histo) {
        return "()" if $histo{$key} % 2;
        for (my $i = $histo{$key}; $i > 0; $i -= 2) {
            $pairs .= "($key $key) ";
        }
    }
    return $pairs;
}

for my $test ([3, 2, 3, 2, 2, 2], [1, 2, 3, 4]) {
    printf "%-15s => ", "@$test";
    say equal_pairs @$test;
}
