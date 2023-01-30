use v5.36;
##
# You are given an array of integers.
# Write a script to find out all Arithmetic Slices for the given array of integers.
##
use boolean;

sub is_arithmetic{
    my($slice) = @_;
    do{
        return false if $slice->[$_] != $slice->[$_ + 1] - 1;
    } for 0 .. @{$slice} - 2;
    return true;
}

sub arithmetic_slices{
    my @slices; 
    my @a = @_;
    return ([]) if @a < 3;
    do{
        my $i = $_;
        do{
            my $slice = [@a[$i .. $i + $_]] if $a[$i] && $a[$i + $_];
            push @slices, $slice if $slice && is_arithmetic($slice);
        } for 2 .. @a - 1;
    } for 0 .. @a - 3;
    return @slices;
}

MAIN:{
    say q/1, 2, 3, 4/;
    for my $slice (arithmetic_slices(1, 2, 3, 4)){
        say q/[/ . join(q/, /, @{$slice}) . q/]/; 
    }
    say q//;
    say q/2/;
    for my $slice (arithmetic_slices(2)){
        say q/[/ . join(q/, /, @{$slice}) . q/]/; 
    }
}