use v5.38;
##
# You are given an array of integers >= 0.
# Write a script to return the largest number formed by concatenating 
# some of the given integers in any order which is also multiple of 3. 
# Return -1 if none found.
##
use Algorithm::Permute;
sub largest_of_three{
    my @digits = @_;
    my $largest = -1;
    do{
        my $indices = $_;
        my @sub_digits = @digits[grep{vec($indices, $_, 1) == 1} 0 .. @digits - 1];
        my $permutor = Algorithm::Permute->new([@sub_digits]);
        while(my @permutation = $permutor->next()){
            my $d = join q//, @permutation;
            $largest = $d if $d > $largest && $d % 3 == 0;
        }
    } for 1 .. 2**@digits - 1;
    return $largest;
}

MAIN:{
    say largest_of_three 8, 1, 9;
    say largest_of_three 8, 6, 7, 1, 0;
    say largest_of_three 1;
}