#!/usr/bin/perl

use strict;
use warnings;

main: {
    my @dispatch = (
        sub {print 'The'; 7},
        sub {print '034'; 6},
        sub {print '2'; 3},
        sub {print 'by'; 5},
        sub {print 'challenge'; 1},
        sub {print 'jo.'; undef},
        sub {print 'task'; 2},
        sub {print 'weekly'; 4},
    );

    for (my $i = 0; defined $i; $i = $dispatch[$i]()) {
        print ' ' if $i;
    }
    print "\n";
}

