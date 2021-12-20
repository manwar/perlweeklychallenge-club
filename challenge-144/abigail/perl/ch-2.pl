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
    die unless $u1 > 0 && $u2 > 0 && $u1 != $u2
            && $u1 == int $u1 && $u2 == int $u2;
    ($u1, $u2) = ($u2, $u1) if $u1 > $u2;

    my @seen = ($u1, $u2);
    my %sums;
       $sums   {$u1 + $u2} = 1;
    my %todo = ($u1 + $u2, 1);

    while (%todo) {
        my $next = min keys %todo;
        delete $todo {$next};
        next if $sums {$next} > 1;
        push   @seen => $next;
        return @seen if @seen >= 10;

        foreach my $seen (@seen) {
            next if $seen == $next;
            my $sum = $seen + $next;
            $sums {$sum} ++;
            $todo {$sum} = 1;
        }
    }
}

$, = ", ";
say ulam /[0-9]+/g while <>;

