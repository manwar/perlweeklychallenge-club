use strict;
use warnings;
##
# Create a script that generates Pascal Triangle. 
# Accept number of rows from the command line. 
# The Pascal Triangle should have at least 3 rows.
## 

##
# How to compute Pascal's Triangle. 
# After the inital row(s) with 1 entries, the entry for the n-th row and k-th column is defined as
#                             (n-1)!             (n-1)!                             
#                       -------------------- + ------------
#                       (k-1)!((n-1)-(k-1))!   k!((n-1)-k)!  
##

sub compute_entry{
    my($row, $column) = @_;
    unless($row < 2){
        my($x0, $y0, $x1, $y1);  
        $x0 = factorial($row - 1);  
        $y0 = factorial($column - 1) * factorial(($row - 1) - ($column - 1));             
        $x1 = factorial($row - 1);  
        $y1 = factorial($column) * factorial(($row - 1) - $column); 
        return int($x0 / $y0) + int($x1 / $y1);   
    } 
    return 1;   
} 

sub factorial{
    my($n) = @_;
    unless($n < 1){
        return $n * factorial($n - 1); 
    }
    return 1;  
}

##
# Main    
##  
my $max = $ARGV[0];  
my $padding = " ";
my $padding_length = $max;  
for my $i (1 .. $max){
    $padding_length = $padding_length - 1;  
    print $padding x $padding_length;  
    for my $j (1 .. $i){
        print compute_entry($i - 1, $j - 1) . " ";  
    } 
    print "\n";       
} 
