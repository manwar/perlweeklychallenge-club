use strict;
use warnings;
use experimental 'signatures';
use feature 'say';

sub interleaved($a, $b, $c) {
    ($a, $b) = ($b, $a) if length $a < length $b;
    my ($is_a, $is_b) = (0, 0);
    $c =~ s/(\Q$a\E)|\Q$b\E/ $1 and ++$is_a or ++$is_b; '' /e for 1 .. 2;
    $c eq q() && ($is_a && $is_b || $a eq $b)
}

say interleaved(@ARGV) ? 1 : 0;
