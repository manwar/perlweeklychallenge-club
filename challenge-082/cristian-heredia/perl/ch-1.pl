=begin
    TASK #1 › Common Factors
    Submitted by: Niels van Dijke
    You are given 2 positive numbers $M and $N.
   
    Write a script to list all common factors of the given numbers.
   
    Example 1:
    Input:
        $M = 12
        $N = 18
   
    Output: (1, 2, 3, 6)
   
    Explanation:
        Factors of 12: 1, 2, 3, 4, 6
        Factors of 18: 1, 2, 3, 6, 9
    Example 2:
    Input:
        $M = 18
        $N = 23
   
    Output: (1)
   
    Explanation:
        Factors of 18: 1, 2, 3, 6, 9
        Factors of 23: 1
=end
=cut

use strict;
use warnings;
use Data::Dumper;

#Variables
my $M = 12;
my $N = 18;
my $factor;
my @factors;
my %count;
my @sorted;
my @result;

factorsImput($M);
factorsImput($N);
obtainFactor();

sub factorsImput {
   
    $factor = shift;
   
    foreach (my $i=1; $i< $factor; $i++ ) {
        if ($factor % $i == 0) {
            push @factors, $i;
        }
    }
}

sub obtainFactor {
   
    $count{$_}++ foreach @factors;
   
    while (my ($key, $value) = each(%count)) {
       
        if ($value == 2) {
            push @result, $key;
        }
    }
    @sorted = sort { $a <=> $b } @result;
    printResult();
   
}

sub printResult {
   
    my $string = join( ', ', @sorted );
    print "Output: ($string)\n";
}
