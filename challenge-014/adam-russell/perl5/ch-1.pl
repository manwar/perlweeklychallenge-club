use strict;
use warnings; 
##
# Write a script to generate Van Eck’s sequence starts with 0.
##
my $i = 1; 
my @sequence = (0, 0);
print join(" ", @sequence) . " "; 
{
    my $last_index = (sort { $b <=> $a} grep { $sequence[$_] == $sequence[$i] } 0..(@sequence - 2))[0]; 
    $i++; 
    $sequence[$i] = defined($last_index) ? ($i - $last_index - 1) : 0;
    print $sequence[$i] . " "; 
    redo;
} 
