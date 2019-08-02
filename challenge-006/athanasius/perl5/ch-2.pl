use strict;
use warnings;
use Const::Fast;
use Math::BigFloat;

const my $INT_DIGITS =>  18;
const my $HEEGNER    => 163;
const my $PRECISION  =>  33;
const my $ACCURACY   => $INT_DIGITS + $PRECISION + 3;

Math::BigFloat->accuracy($ACCURACY);

my $squareroot = Math::BigFloat->new($HEEGNER)->bsqrt();  #         sqrt(163)
my $ramanujan  = Math::BigFloat->bpi();                   #    pi
$ramanujan->bmul($squareroot);                            #    pi * sqrt(163)
$ramanujan->bexp();                                       # e^(pi * sqrt(163))
$ramanujan->bfround(-$PRECISION);                         # to 33 decimal places

print "\n$ramanujan\n";

__END__

0:37 >perl ch-2.pl
