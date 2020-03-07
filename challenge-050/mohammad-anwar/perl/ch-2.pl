#!/usr/bin/perl

use strict;
use warnings;

use List::Util 1.54 qw(sample);

my $COUNT = $ARGV[0] || 3;

my @L = sort { $a <=> $b } sample ($COUNT, (1 .. 50));
my $N = find_noble_number(@L);

(defined $N)
?
(print "Found Noble number $N.\n")
:
(print "None Noble number found.\n");

#
#
# METHOD

sub find_noble_number {
    my (@L) = @_;

    foreach my $N (@L) {
        return $N if (scalar( grep { $_ > $N } @L ) == $N);
    }

    return;
}
