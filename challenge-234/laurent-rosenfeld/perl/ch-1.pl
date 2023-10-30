use strict;
use warnings;
use feature 'say';

sub common_chars {
    my $count = scalar @_;
    my @letters = map { [ split // ] } @_;
    my %histo;       # letter histogram
    for my $w_ref (@letters) {
        my %unique = map { $_ => 1 } @$w_ref;
        $histo{$_}++ for keys %unique;
    }
    my @result = grep { $histo{$_} == $count } keys %histo;
    return "@result";
}

for my $test ([<java javascript julia>],
    [<bella label roller>], [<cool lock cook>]) {
    printf "%-25s => ", "@$test";
    say common_chars @$test;
}
