use v5.36;
##
# You are given an array of unique numbers.
# Write a script to find out all missing numbers 
# in the range 0..$n where $n is the array size.
##
use boolean;
sub missing_numbers{
    my @numbers = @_;
    my %h;
    do { $h{$_} = undef } for @numbers;
    my @missing = grep { !exists($h{$_}) } 0 .. @numbers;
    return @missing;
}

MAIN:{
    say q/(/ . join(q/, /, missing_numbers(0, 1, 3)) . q/)/;
    say q/(/ . join(q/, /, missing_numbers(0, 1)) . q/)/;
    say q/(/ . join(q/, /, missing_numbers(0, 1, 2, 2)) . q/)/;
}