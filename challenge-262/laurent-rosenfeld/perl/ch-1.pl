use strict;
use warnings;
use feature 'say';

sub max_pos_neg {
    my $pos_count = scalar grep {$_ > 0} @_;
    my $neg_count = scalar grep {$_ < 0} @_;
    $pos_count > $neg_count ? $pos_count : $neg_count;
}

my @tests = ( [<-3 1 2 -1 3 -2 4>],
              [<-1 -2 -3 1>], [<1 2>] );
for my $test (@tests) {
    printf "%-20s => ", "@$test";
    say max_pos_neg @$test;
}
