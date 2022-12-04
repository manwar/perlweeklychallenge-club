use v5.36;
##
# You are given an integer, $n > 0.
# Write a script to find all possible binary numbers of size $n.
##
sub binary_numbers_size_n{
    my($n) = @_;
    my @numbers = map {
        sprintf("%0${n}b", $_)
    } 0 .. 2**$n - 1;
    return @numbers;
}

MAIN:{
    say join(", ", binary_numbers_size_n(2));
    say join(", ", binary_numbers_size_n(3));
    say join(", ", binary_numbers_size_n(4));
}