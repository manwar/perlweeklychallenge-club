use strict;
use warnings;
##
# You are given a list of numbers and a set of indices 
# belonging to the list. Write a script to sort the values 
# that belong to the indices.
##
use Readonly;
Readonly::Array my @A => qw/10 4 1 8 12 3/;
Readonly::Array my @INDICES => qw/0 2 5/;

my @sorted = @A; 
my @sorted_values = sort {$a <=> $b} map {$A[$_]} @INDICES;  
my @sorted_indices = sort {$a <=> $b} @INDICES;
for my $i (@sorted_indices){
    $sorted[$i] = shift @sorted_values;  
}
print join(", ", @sorted) . "\n";  
