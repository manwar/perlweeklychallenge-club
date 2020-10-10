=begin

TASK #2 › Count Candies
Submitted by: Mohammad S Anwar
You are given rankings of @N candidates.

Write a script to find out the total candies needed for all candidates. You are asked to follow the rules below:

a) You must given at least one candy to each candidate.
b) Candidate with higher ranking get more candies than their mmediate neighbors on either side.

=end
=cut

use strict;
use warnings;
use Data::Dumper;

#Variables
my @N = (1, 4, 3, 2);
my $candies = @N;
my $lengh = @N;

#print "Candies = $candies\n";
secondRule();
print "Output = $candies\n";

sub secondRule {

    foreach (my $i = 0; $i<$lengh; $i++) {
        if ($i == 0 and $N[$i] > ($i + 1)) {
            $candies++;
        }
        if ($i == ($lengh - 1) and $N[$i] > ($i + 1)) {
            $candies++;
        }
        if ($N[$i] > ($i + 1) and $i != 0) {
            $candies++;
        }
        if ($N[$i] > ($i - 1) and $i != 0) {
            $candies++;
        }
    }
}