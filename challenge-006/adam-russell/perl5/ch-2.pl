use strict;
use warnings;
##
# Create a script to calculate Ramanujan’s constant with at least 32 digits of precision.
## 
use Math::BigFloat;  
my $accuracy = $ARGV[0];  
my $x = new Math::BigFloat(163);
$x -> bsqrt();
$x -> bmul(Math::BigFloat->bpi());  
$x -> bexp($accuracy); 
print "$x\n";  
