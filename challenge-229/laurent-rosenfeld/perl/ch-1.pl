use strict;
use warnings;
use feature 'say';

sub unsorted {
    my $count = 0;
    for my $str (@_) {
        my @let = sort split //, $str;
        $count++ if $str ne join "", @let and
        $str ne join "", reverse @let;
    }
    return $count;
}
for my $test ([<abc bce cae>], [<yxz cba mon>]) {
    # print $test;
    printf "%-12s => ", "@$test";
    say unsorted @$test;
}
