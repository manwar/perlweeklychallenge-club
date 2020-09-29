use strict;
use warnings;
use List::MoreUtils qw(uniq);
use feature 'say';
use bigint;

sub min_slot {
    my $expected = 1;
    for my $number ( uniq sort {$a - $b} grep {$_ > 0} @ARGV ) {
        return --$expected if $expected++ != $number;
    }
    return 0; # no empty *slot*
}

say 'Min slot: ' . min_slot;
