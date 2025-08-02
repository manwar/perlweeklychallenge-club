use strict;
use warnings;
use feature 'say';

sub string_score {
    my $result = 0;
    my @let = split //, shift;
    for my $i (1 .. $#let) {
        $result += abs (ord($let[$i]) - ord($let[$i - 1]));
    }
    return $result;
}
for my $test (qw<hello perl raku>) {
    printf "%-8s => ", $test;
    say string_score $test;
}
