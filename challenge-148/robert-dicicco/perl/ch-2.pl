#!perl.exe

use strict;
use warnings;
use 5.30.0;

### Author: Robert DiCicco
### Date: 17-JAN-2022
### Challenge 148 Cardano Triplets

use constant MAX => 100;

my $bc;
my $count = 0;

foreach my $aval ( 1..MAX ){
    foreach my $bval ( 1..MAX ){
        foreach my $cval ( 1..MAX ){
            my $ret = isCardano( $aval, $bval, $cval );
            if( $ret == 1 ){
                $count++;
                print("Count: $count\t\( $aval,$bval,$cval \)\n");
            }
            last if( $count == 10 );
        }
    }
}

sub isCardano {
    my $a = int(shift);
    my $b = int(shift);
    my $c = int(shift);

    $bc = $b * ( $c ** (1/2) );

    my $val1 = ($a + $bc) ** (1/3);
    my $val2 = abs(($a - $bc)) ** (1/3);
    my $val3 = $val1 - $val2;

    if( $val3 < 1.00001 and $val3 > 0.999999 ){
        return 1;
    } else {
        return 0;
    }
}
