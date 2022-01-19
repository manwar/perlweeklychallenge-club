#!perl.exe

use strict;
use warnings;
use Test::More;

### Challenge #145  Dot Product
### Author --- Robert DiCicco
### Date --- 27-DEC-2021

my @a = qw( 1 2 3 );
my @b = qw( 4 -5 6 );
my $dotprod = dpcalc( \@a, \@b, scalar(@a) );

is($dotprod, 12, "dot product of \(@a\) and \(@b\)");

@a = qw( -4 -9 );
@b = qw( -1 2 );
$dotprod = dpcalc( \@a, \@b, scalar(@a) );

is($dotprod, -14, "dot product of \(@a\) and \(@b\)");

@a = qw( 6 -1 3);
@b = qw( 4 18 -2);

$dotprod = dpcalc( \@a, \@b, scalar(@a) );

is($dotprod, 0, "dot product of \(@a\) and \(@b\)");

done_testing;

sub dpcalc {
    my ($aref, $bref, $len) = @_;
    my $val = 0;
    foreach my $i ( 0 .. ($len - 1) ){
       $val += $aref->[$i] * $bref->[$i];
    }

    return($val);
}
