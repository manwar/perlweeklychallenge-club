use v5.38;
##
# You are given an array of integers.
# Write a script to find out the total special quadruplets for the given array.
##
sub special_quadruplets{
    my @numbers = @_;
    my @special_quadruplets;
    do{
        my $s = $_;
        do{
            my $t = $_;
            do{
                my $u = $_;
                do{
                    my $v = $_;
                    push @special_quadruplets, [$s, $t, $u, $v] if $s < $t && $t < $u && $u < $v && ($numbers[$s] + $numbers[$t] + $numbers[$u] == $numbers[$v]);
                } for $u + 1 .. @numbers - 1;
            } for $t + 1 .. @numbers - 1;
        } for $s + 1 .. @numbers - 1;
    } for 0 .. @numbers - 1;
    return @special_quadruplets;
}

MAIN:{
    say 0 + special_quadruplets 1, 2, 3, 6;
    say 0 + special_quadruplets 1, 1, 1, 3, 5;
    say 0 + special_quadruplets 3, 3, 6, 4, 5;
}