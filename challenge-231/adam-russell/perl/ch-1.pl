use v5.38;
##
# You are given an array of distinct integers.
# Write a script to find all elements that is neither minimum nor maximum. 
# Return -1 if you can’t.
##
sub not_min_max{
    my($minimum, $maximum);
    do{
        $minimum = $_ if !$minimum || $_ < $minimum;
        $maximum = $_ if !$maximum || $_ > $maximum;
    } for @_;
    my @r = grep { $_ ^ $minimum && $_ ^ $maximum } @_;
    return @r ^ 0 ? @r : -1;
}

MAIN:{
    say join q/, /, not_min_max 3, 2, 1, 4;
    say join q/, /, not_min_max 3, 1;
    say join q/, /, not_min_max 2, 1, 3;
}