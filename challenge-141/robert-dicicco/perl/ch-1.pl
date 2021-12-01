#!perl.exe

use strict;
use warnings;
use ntheory qw/ divisors /;

### Author: Robert DiCicco
### Date: 29-NOV-2021
### Challenge #141 Number Divisors

my $FACNUM = 8;
my $LIMIT = 10;
my ($fnd,$num) = 0;

while(1){
    $num++;
    my @d = divisors($num);
    if(scalar(@d) == $FACNUM){
        print("$num =  ");
        foreach my $n (@d){
            print($n . " ");
        }
        print("\n");
        $fnd++;
        last if($fnd == $LIMIT );
       }
}
