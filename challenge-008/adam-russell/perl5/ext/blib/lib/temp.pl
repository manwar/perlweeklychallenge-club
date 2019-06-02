use strict;
use warnings;

use perfect;  

use Data::Dump q/pp/; 

my $p=new perfect::Perfect(); 
foreach my $x (0..10000){  
    if($p->isPerfect($x)){
        print "$x ";
    } 
}
print "\n";    
