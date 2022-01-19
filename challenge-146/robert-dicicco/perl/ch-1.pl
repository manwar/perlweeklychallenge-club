#!perl.exe

use strict;
use warnings;
use ntheory qw/ next_prime /;

### AUTHOR: Robert DiCicco
### DATE:   04-JAN-2022
### Challenge #145 10001st Prime

my $cnt = 0;
my $i = 1;

my $TARGET = 10001;

while($cnt <= $TARGET){
    if($cnt == $TARGET ){
        last;
     }

     $cnt++;
     $i = next_prime($i);
}

print("Count = $cnt : prime = $i\n");
