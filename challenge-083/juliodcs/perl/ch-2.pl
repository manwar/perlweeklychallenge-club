use strict;
use warnings;
use feature 'say';
use experimental 'signatures';
use List::Util 'sum0';
use Const::Fast;

sub _count_flips($list, $pos, $flips, $acc, $max) {    
    return $flips 
        if $pos > $list->@* - 1 # End of array
        || $acc == $max;        # short-circuit

    const my $current   => $list->[$pos];
    const my $can_add   => $max >= $acc + $current;
    const my $new_flips => $can_add ? $flips + 1 : $flips;
    const my $new_acc   => $can_add ? $acc + $current : $acc;

    return _count_flips($list, $pos + 1, $new_flips, $new_acc, $max);
}

sub flip_array(@list) {
    const my $max => int sum0(@list) / 2;
    const my @sorted => sort { $b - $a } @list;
    return _count_flips(\@sorted, 0, 0, 0, $max);
}

if (@ARGV > 0) {
    say join q(, ), @{flip_array(\@ARGV)};
    exit 0;
}

use Test::More;

is flip_array(1), 0, 'One element';
is flip_array(1, 1), 1, 'Two equal elements';
is flip_array(2, 1), 1, 'Two different elements';
is flip_array(1, 2), 1, 'Two different elements - unsorted';
is flip_array(1, 2, 1), 1, 'turn middle element';
is flip_array(1, 2, 1, 4, 8), 1, 'turns one element (8)';
is flip_array(1, 2, 1, 4, 8, 1, 4, 3), 2, 'turns two elements (8, 4)';
is flip_array(2, 12, 15), 2, 'turns two element (12, 2)';
is flip_array(3, 12, 15), 1, 'turns one element (15)';
is flip_array(12, 0, 0, 0, 0, 12), 1, 'Equal elements with zeroes';
is flip_array(0, 1, 1, 2, 2, 2, 1, 1, 0), 3, 'Three flips';
is flip_array(3, 10, 8), 1, 'Example 1';
is flip_array(12, 2, 10), 1, 'Example 2';

done_testing;
