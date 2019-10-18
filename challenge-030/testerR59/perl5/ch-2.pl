use strict;
use warnings;

for my $x(1..10){
    for my $y(1..10){
        for my $z(1..10){
            print "$x, $y, $z\n" if $x + $y + $z == 12
        }
    }
}
