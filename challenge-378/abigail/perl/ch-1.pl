#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (my $line = <>) {
    my $max = -1;
    my $sec = -1;
    foreach my $ch ($line =~ /[0-9]/g) {
        #
        # Iterate over the digits. If it's larger than the current max,
        # set the second to the match, and the max to the current digit.
        # If it's less than the max, but larger than the second, set the
        # second to the current digit. 
        # Note that if the current digit equals the max (or the second),
        # we do not do anything.
        #
        if    ($max < $ch)        {$sec = $max; $max = $ch}
        elsif ($max > $ch > $sec) {$sec = $ch}
    }
    say $sec;
}

__END__
