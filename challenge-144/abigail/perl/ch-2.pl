#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

use List::Util qw [min];

#
# See ../README.md
#

#
# Run as: perl ch-2.pl < input-file
#

sub ulam ($u1, $u2) {
    my @seen = ($u1,  $u2);
    my %sums = ($u1 + $u2, 1);

    my $next;
    while (%sums) {
        $next = min keys %sums;  # A heap saves a factor N/log N, but
                                 # who cares about performance when we
                                 # just want to do the first 10 numbers?
        next if delete $sums {$next} > 1;
        push   @seen => $next;
        return @seen if @seen >= 10;

        $_ == $next || $sums {$_ + $next} ++ foreach @seen;
    }
}



$, = ", ";
say ulam /[0-9]+/g while <>;

