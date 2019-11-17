use strict;
use warnings;
##
# Write a program that demonstrates using hash slices and/or array slices.
##
my %h = (
    1 => "first", 
    2 => "second", 
    3 => "third", 
    4 => "fourth"
); 
my @a = @h{2, 4};
print join("\n", @a) . "\n";  
