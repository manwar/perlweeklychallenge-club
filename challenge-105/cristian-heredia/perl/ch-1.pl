=begin

TASK #1 › Nth root
Submitted by: Mohammad S Anwar
You are given positive numbers $N and $k.

Write a script to find out the $Nth root of $k. For more information, please take a look at the wiki page.

    Example
        Input: $N = 5, $k = 248832
        Output: 12
        
        Input: $N = 5, $k = 34
        Output: 2.02

=end
=cut

use strict;
use warnings;


#Inputs
my $N = 5;
my $k = 34;

calculeRoot();

sub calculeRoot {
    my $result =  $k ** (1/$N);
    #Two decimals
    $result = sprintf("%.2f", $result);
    #Remove trailing zeros
    $result = sprintf("%g",$result);
    print "$result\n";
}

