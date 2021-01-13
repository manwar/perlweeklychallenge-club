#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

while (<>) {
    my @N = /[0-9]+/g;
    #
    # The second example will die on this. Because 0 ain't no positive number.
    #
    die "Not all positive integers" if grep {/[^0-9]/ || !$_} @N;
    my $index = 0;
    while ($index < @N - 1) {
        #
        # Note that we ALWAYS make progress, as it's given that
        # @N contains POSITIVE numbers.
        #
        $index += $N [$index];
    }
    say $index == $#N ? 1 : 0;
}

__END__
