#!/usr/bin/env perl
#
# ch-2.pl - Collatz sequence
#
# Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';
use List::Util qw/first shuffle/;
use Data::Dump qw/pp dd/;

use Getopt::Long;

my @seqlen = (-1,1);    # Memoize sequence length
my $top    = 20;        # Report this many of the top sequences
my @top    = [ -1,-1 ]; # Top $top sequences
my $upper  = 1e6;       # Upper limit starting term
my $mintop = 0;         # Lowest value in @top

GetOptions('top=i' => \$top, 'upper=i' => \$upper);

# Run through the upper limit
for (my $start = 3; $start < $upper; $start += 2) {
    my ($n, $len) = ($start, 0);
    while (! defined $seqlen[$n]) {
        $len += 1 + $n % 2;
        $n = $n % 2 ? (3*$n + 1)/2 : $n / 2;
    }
    $len += $seqlen[$n];
    $seqlen[$start] = $len if $start < $upper * 2; # Cache
    top($start => $len)            if $len > $mintop  and     $start <= $upper;
    top($n * 2 => $seqlen[$n] + 1) if   $n < $upper/2 and $seqlen[$n] > $mintop;
}

# Report top sequences
printf "Collatz(%5d) has sequence length of %3d steps\n", @$_ for @top;

# Sorted insert [ $n, $len ] to @top, keep @top to $top length
sub top {
    my ($n, $len) = @_;

    my $idx = first { $top[$_][1] < $len } 0..$#top;
    splice @top, $idx, 0, [ $n, $len ];

    pop @top if @top > $top;
    $mintop = $top[-1][1];
}
