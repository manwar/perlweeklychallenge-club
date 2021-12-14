#!perl.exe

use strict;
use warnings;

### Author: Robert DiCicco
### Date: 13-DEC-2021
### Challenge #143 Calculator

use Math::Calc::Parser 'calc';
use utf8;

print("Enter a math expression to calculate : ");
my $problem = <>;
chomp($problem);

my $result = calc $problem;
print("$problem = $result\n");
