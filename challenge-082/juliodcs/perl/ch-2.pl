use strict;
use warnings;
use experimental 'signatures';
use feature 'say';

sub interleaved($a, $b, $c) {
    ($a, $b) = ($b, $a) if length $a < length $b;
    my $found = 0
    $c =~ s/\Q$a\E|\Q$b\E/ $found++; '' /e for 1 .. 2;
    $c eq q() && ($found == 2 || $a eq $b)
}

say interleaved(@ARGV) ? 1 : 0;
