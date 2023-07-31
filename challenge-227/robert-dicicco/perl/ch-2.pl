#!/usr/bin/env perl
=begin comment
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-25
Challenge 227 Task 2 Roman Maths ( Perl )
--------------------------------------
=cut
use strict;
use warnings;
use v5.38;
use Math::Roman qw/tokens roman /;

my $problem = $ARGV[0];

my @parts = split(" ",$problem);

my $left = $parts[0];
my $op = $parts[1];
my $right = $parts[2];
### added tokens for 4, 9, 40, 90, 400, and 900
Math::Roman::tokens( qw(I 1  IV 4  V 5  IX 9 X 10  XL 40 L 50  XC 90 C 100  XD 400 D 500  CM 900 M 1000 ));

my $lft = Math::Roman::roman($left);  # convert ascii arg to roman numeral
$lft = $lft->as_number();             # and convert it to an arabic number for use in math
my $rt = Math::Roman::roman($right);
$rt = $rt->as_number();

if ($lft - $rt == 0) {
    print("$left $op $right est nulla\n");
    exit;
}
if ($op eq '/' and ($lft % $rt) > 0 ) {
    print("$left $op $right non potest\n");
    exit;
}
if ($lft + $rt > 3999) {
    print("$left $op $right non potest\n");
    exit;
}
if ($op eq '-' and ($lft - $rt < 0)) {
    print("$left $op $right non potest\n");
    exit;
}

my $val = 0;
if ( $op eq '+') {
    $val = roman($lft + $rt);
} elsif ( $op eq '-') {
    $val = roman($lft - $rt);
} elsif ($op eq '/') {
    $val = roman($lft / $rt);
} elsif ($op eq '*') {
    $val = roman($lft * $rt);
} elsif ($op eq '**') {
    $val = roman($lft ** $rt);
}

print("$left $op $right => $val\n");

=begin comment
--------------------------------------
SAMPLE OUTPUT
perl .\RomanMath.pl "IV + V"
IV + V => IX

perl .\RomanMath.pl "M - I"
M - I => CMXCIX

perl .\RomanMath.pl "X / II"
X / II => V

perl .\RomanMath.pl "XI * VI"
XI * VI => LXVI

perl .\RomanMath.pl "VII ** III"
VII ** III => CCCXLIII

perl .\RomanMath.pl "V - V"
V - V est nulla

perl .\RomanMath.pl "V / II"
V / II non potest

perl .\RomanMath.pl "MMM + M"
MMM + M non potest

perl .\RomanMath.pl "V - X"
V - X non potest
--------------------------------------
=cut



