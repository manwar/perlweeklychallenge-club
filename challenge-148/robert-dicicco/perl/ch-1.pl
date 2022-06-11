#!perl.exe

use strict;
use warnings;
use Lingua::EN::Numbers qw(num2en);

### Author: Robert DiCicco
### Date: 17-JAN-2022
### Challenge 148 Eban Numbers

my $n = 0;
while($n < 100){
    my $engnum = num2en($n);
    if(index($engnum, 'e') == -1 ){
        print("$n ");
    }
    $n++;
}

print("\n");
