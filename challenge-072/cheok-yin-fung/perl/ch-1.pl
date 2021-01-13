#!/usr/bin/perl
# Perl Weekly Challenge #072 Task 1
# Usage:  ch-1.pl $N  
use strict;
use warnings;
#use Test::More tests => 7;

my $N;
if ($ARGV[0]) { $N=$ARGV[0]; }  else { $N = 5; }

sub tzero {
    my $_N = $_[0];
    my $fivepow = 5;

    my $ans = 0;

    while ( $fivepow <= $_N ) {
        $ans += (int ($_N/$fivepow) );
        $fivepow*=5;
    }

    return $ans;
}

print tzero($N), "\n";

=pod
ok tzero(10) == 2, 'pass test case N=10';
ok tzero(7) == 1, 'pass test case N=7';
ok tzero(4) == 0, 'pass test case N=4';
ok tzero(25) == 6, 'pass test case N=25';
ok tzero(30) == 7, 'pass test case N=30';
ok tzero(50) == 12, 'pass test case N=50';
ok tzero(100) == 24, 'pass test case N=100';
=cut
