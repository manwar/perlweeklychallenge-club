use strict;
use warnings;
use feature 'say';

sub exp_three {
    my $in = shift;
    return "true" if $in == 0;
    my $exp = int (log $in / log 3);
    return (3 ** $exp == $in or 3 ** ($exp + 1) == $in)
        ? "true" : "false";
}

say "$_ \t=> ", exp_three $_ for qw<27 26 0 6>;
