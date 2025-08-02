use strict;
use warnings;
use feature 'say';

sub sort_dom  {
    my $dom = shift;
    my ($a, $b) = split //, $dom;
    return $a < $b ? $dom : "$b$a";
}

sub similar_dom {
    my %histo;
    $histo{$_}++ for map { sort_dom $_ } @_;
    my $count = 0;
    $count += $_ for grep { $_ > 1 } values %histo;
    return $count;
}

my @tests = ( [<13 31 24 68>], [<12 21 11 12 22>],
                [<31 24 13 56 24>] );
for my $test (@tests) {
    printf "%-15s => ", "@$test";
    say similar_dom @$test;
}
