use strict;
use warnings;
##
# Implement a subroutine gamma() using the Lanczos approximation method.
##
use POSIX;
use Math::Complex;

use constant EPSILON => 1e-07;

sub lanczos{
    my($z) = @_;
    my @p = (676.5203681218851, -1259.1392167224028, 771.32342877765313, -176.61502916214059, 12.507343278686905, -0.13857109526572012, 9.9843695780195716e-6, 1.5056327351493116e-7);
    my $y;
    $z = new Math::Complex($z);
    if(Re($z) < 0.5){
        $y = M_PI / (sin(M_PI * $z) * lanczos(1 - $z));
    }
    else{
        $z -= 1;
        my $x = 0.99999999999980993;
        for my $i (0 .. @p - 1){
            $x += ($p[$i] / ($z + $i + 1));
        }
        my $t = $z + @p - 0.5;
        $y = sqrt(2 * M_PI) * $t ** ($z + 0.5) * exp(-1 * $t) * $x;
    }
    return Re($y) if abs(Im($y)) <= EPSILON;
    return $y;
}

sub gamma{
    return lanczos(@_);
}

MAIN:{
    print gamma(3) . "\n";
    print gamma(5) . "\n";
    print gamma(7) . "\n";
}