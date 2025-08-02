use strict;
use warnings;
use feature 'say';

sub thirty_three_pct {
    my $count = scalar @_;
    return "Undef" if $count == 0;
    my $limit = $count * .33;
    my %histo;
    $histo{$_}++ for @_;
    my @eligibles = sort {$a <=> $b}
                    grep { $histo{$_} > $limit } keys %histo;
    return @eligibles ? $eligibles[0] : "Undef";
}

my @tests = ([<1 2 3 3 3 3 4 2>], [<1 2>], [<1 2 3>],
             [<1 2 1 2 1 2 1 2>], [<1 2 3 4 1 2 3 4>]);
for my $test (@tests) {
    printf "%-18s => ", "@$test";
    say thirty_three_pct @$test;
}
