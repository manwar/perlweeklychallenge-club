#!/usr/bin/perl

# Challenge 002
#
# Challenge #2
# Write a script that can convert integers to and from a base35
# representation, using the characters 0-9 and A-Y. Dave Jacoby came up
# with nice description about base35, in case you needed some background.

use strict;
use warnings;
use 5.030;

use constant { BASE => 35 };
my @digits = ('0'..'9','A'..'Z');

our $opt_r;
($opt_r = 1, shift) if @ARGV && $ARGV[0] eq '-r';
@ARGV==1 or die "Usage: ch-2.pl [-r] number\n";
if ($opt_r) {
    say scan_number($ARGV[0], BASE);
}
else {
    say format_number($ARGV[0], BASE);
}


sub format_number {
    my($n, $base) = @_;
    my $negative = ($n < 0);
    $n = abs($n);
    my $output = '';
    do {
        my $d = $n % $base;
        $n = int($n / $base);
        $output = $digits[$d].$output;
    } while ($n > 0);
    $output = "-".$output if $negative;
    return $output;
}

sub scan_number {
    my($str, $base) = @_;
    my $n = 0;
    my $negative;
    $negative = 1 if $str =~ s/^-//;
    while ($str =~ s/^(\w)//) {
        my $c = $1;
        my $d = ($c =~ /\d/) ? 0+$c : ord(uc($c))-ord('A')+10;
        $d < $base or die "cannot parse $c$str\n";
        $n = $base * $n + $d;
    }
    $str eq '' or die "cannot parse $str\n";
    $n = -$n if $negative;
    return $n;
}
