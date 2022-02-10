#!perl.exe

use strict;
use warnings;
use experimental 'say';
use List::Util qw(sum0);
use Math::Fibonacci qw(isfibonacci);

### Author: Robert DiCicco
### Date: 25-JAN-2022
### Challenge 149  Fibonacci Digit Sum (Perl)

my $fibcnt = 20;
my @expected = (0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41, 44);

my $cnt = 0;
while($fibcnt){
    my $sumval = SingleSumOfDigits($cnt);
    if(isfibonacci($sumval)){
        print("$cnt ");
        $fibcnt--;
    }

    $cnt++;
}
