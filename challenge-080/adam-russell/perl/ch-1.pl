use strict;
use warnings;
##
# You are given an unsorted list of integers @N.
# Write a script to find out the smallest positive number missing.
##
sub least_missing{
    my(@numbers) = @_;
    @numbers = sort @numbers;
    for my $i ($numbers[0] .. $numbers[@numbers - 1]){
        my @a = grep { $_ == $i } @numbers;
        return $i if(!@a && $i > 0);
    }
    return undef;
}

MAIN:{
    my @N;
    @N = (5, 2, -2, 0);
    my $least_missing = least_missing(@N);
    print "The least mising number from (" .
        join(",", @N) . ") is $least_missing\n";
    @N = (1, 8, -1);
    $least_missing = least_missing(@N);
    print "The least mising number from (" .
        join(",", @N) . ") is $least_missing\n";
    @N = (2, 0, -1);
    $least_missing = least_missing(@N);
    print "The least mising number from (" .
        join(",", @N) . ") is $least_missing\n";
}