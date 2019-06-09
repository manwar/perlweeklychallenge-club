use strict;
use warnings;
##
# Write a script to create an Identity Matrix for the given size. 
# For example, if the size is 4, then create Identity Matrix 4x4. 
##
use constant SIZE => 10;

my @a;
for my $i (0 .. SIZE - 1){
    my @b = (0) x SIZE;
    $b[$i] = 1;
    push @a, \@b; 
}
print SIZE . " x " . SIZE . " identity matrix:\n";  
for my $i (0 .. SIZE - 1){
    print "\t" . join(" ", @{$a[$i]}) . "\n"; 
}  
