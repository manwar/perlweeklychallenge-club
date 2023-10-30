use strict;
use warnings;
use feature 'say';

sub unique_srt {
    my %letters = map { $_ => 0 } split //, $_[0];
    return join "", sort keys %letters;
}
sub fact {
    my $num = shift;
    my $fact = 1;
    $fact *= $_ for 2..$num;
    return $fact;
}
sub similar {
    my %words;
    $words{$_}++ for map { unique_srt $_ } @_;
    %words = map { $_ => $words{$_}} grep {$words{$_} > 1} keys %words;
    my $count = 0;
    $count += (fact $words{$_})/2 for keys %words;
    return $count;
}

for my $test ([<aba aabb abcd bac aabc>],
    [<aabb ab ba>], [<nba cba dba>]) {
    printf "%-25s => ", "@$test";
    say similar @$test;
}
