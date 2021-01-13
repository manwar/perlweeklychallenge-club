use strict;
use warnings;
##
# You are given rankings of @N candidates.
# Write a script to find out the total candies needed for all candidates. 
# You are asked to follow the rules below:
#     a) You must given at least one candy to each candidate.
#     b) Candidate with higher ranking get more candies than their immediate
#        neighbors on either side.
##
sub count_candies{
    my(@candidates) = @_;
    my $candies = @candidates;
    for my $i (0 .. (@candidates - 1)){
        if($candidates[$i - 1]){
            $candies++ if $candidates[$i] > $candidates[$i - 1];
        }   
        if($candidates[$i + 1]){
            $candies++ if $candidates[$i] > $candidates[$i + 1];
        }
    }
    return $candies;
}


MAIN:{
    my @N;
    my $number_candies;
    @N = (1, 2, 2);
    $number_candies = count_candies(@N);
    print "The number of candies for (" .
        join(",", @N) . ") is $number_candies\n";
    @N = (1, 4, 3, 2);
    $number_candies = count_candies(@N);
    print "The number of candies for (" .
        join(",", @N) . ") is $number_candies\n";
}