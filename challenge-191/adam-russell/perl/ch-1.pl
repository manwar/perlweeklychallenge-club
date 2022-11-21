use v5.36;
use strict;
use warnings;
##
# You are given list of integers, @list. Write a script to find out whether the largest 
# item in the list is at least twice as large as each of the other items.
## 
use boolean;

sub twice_largest{
    my(@list_integers) = @_;
    my $twice_max = -1;
    for my $i (0 .. @list_integers - 1){
        my $twice_rest = true;
        for my $j (0 .. @list_integers - 1){    
            unless($i == $j){
                $twice_rest = $list_integers[$i] >= 2 * $list_integers[$j];
            }
        }
        $twice_max = $list_integers[$i] if $twice_rest; 
    } 
    return $twice_max>-1?1:-1;
}

MAIN:{
    say twice_largest(1, 2, 3, 4);
    say twice_largest(1, 2, 0, 5);
    say twice_largest(2, 6, 3, 1);
    say twice_largest(4, 5, 2, 3);
}