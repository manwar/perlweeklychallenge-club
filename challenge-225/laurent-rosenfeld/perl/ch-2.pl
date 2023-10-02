use strict;
use warnings;
use feature 'say';

sub lrsd  {
    my @in = @_;
    my @l = (0);
    push @l, $l[-1] + $in[$_] for 0..$#in-1;
    my @r = (0);
    push @r, $r[-1] + $in[$_] for reverse 1..$#in;
    @r = reverse @r;
    return join " ", map { abs ($l[$_] - $r[$_]) } 0..$#l;
}

my @tests = ([10, 4, 8, 3], [1,], [1, 2, 3, 4, 5] );
for my $test (@tests) {
    printf "%-10s => ", "@$test";
    say lrsd @$test;
}
