#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

#
# Compare two times.
# Return -1, 0, 1 if the first time is earlier/equal/later than the second.
#
sub tcmp ($t1, $t2) {
    $$t1 [0] <=> $$t2 [0] || $$t1 [1] <=> $$t2 [1];
}

while (<>) {
    my ($b1, $e1, $b2, $e2) = map {[split /:/]} split;
    #
    # Does any time straddle midnight?
    #
    my $straddle1 = tcmp ($b1, $e1) > 0;
    my $straddle2 = tcmp ($b2, $e2) > 0;

    #
    # If both are straddling midnight, the times intersect
    #
    if ($straddle1 && $straddle2) {
        say "true";
    }

    #
    # If one straddles midnight, add 24 hours to each time earlier
    # than the start time of one straddling midnight
    #
    elsif ($straddle1) {
        #
        # We have an intersection unless b1 >= e2 and e1 <= b2
        #
        say tcmp ($b1, $e2) >= 0 && tcmp ($e1, $b2) <= 0 ? "false" : "true" 
    }
    elsif ($straddle2) {
        #
        # We have an intersection unless b2 >= e1 and e2 <= b1
        #
        say tcmp ($b2, $e1) >= 0 && tcmp ($e2, $b1) <= 0 ? "false" : "true" 
    }
    else {
        #
        # We have an intersection unless e2 < b1 or b2 > e1
        #
        say tcmp ($e2, $b1) <= 0 || tcmp ($b2, $e1) >= 0 ? "false" : "true"
    }
}

__END__
