use strict;
use warnings;
use feature 'say';

sub digit_count_value {
    my @in = @_;
    my %count;
    $count{$_}++ for @in;
    for my $i (0..$#in) {
        return "False" if exists $count{$i} and
            $in[$i] != $count{$i};
    }
    return "True";
}

my @tests = ( [<1 2 1 0>], [<0 3 0>] );
for my $test (@tests) {
    printf "%-8s => ", "@$test";
    say digit_count_value @$test;
}
