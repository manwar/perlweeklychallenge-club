use v5.36;
use strict;
use warnings;
##
# You are given list of integers, @list. Write a script to find out whether the largest 
# item in the list is at least twice as large as each of the other items.
## 
sub twice_largest{
    my(@list_integers) = @_;
    my @sorted_integers = sort {$a <=> $b} @list_integers;
    for my $i (@sorted_integers[0 .. @sorted_integers - 1]){
        unless($sorted_integers[@sorted_integers - 1] == $i){
            return -1 unless $sorted_integers[@sorted_integers - 1] >= 2 * $i; 
        }
    }
    return 1;
}

MAIN:{
    say twice_largest(1, 2, 3, 4);
    say twice_largest(1, 2, 0, 5);
    say twice_largest(2, 6, 3, 1);
    say twice_largest(4, 5, 2, 3);
}