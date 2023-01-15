use v5.36;
##
# You are given an array of integers, @array and three integers $x,$y,$z.
# Write a script to find out total Good Triplets in the given array.
# A triplet array[i], array[j], array[k] is good if it satisfies the following conditions:
#    a) 0 <= i < j < k <= n (size of given array)
#    b) abs(array[i] - array[j]) <= x
#    c) abs(array[j] - array[k]) <= y
#    d) abs(array[i] - array[k]) <= z
##
use Math::Combinatorics;
sub good_triplets{
    my($numbers, $x, $y, $z) = @_;
    my $combinations = Math::Combinatorics->new(count => 3, data => [0 .. @{$numbers} - 1]);
    my @combination = $combinations->next_combination;  
    my @good_triplets;
    {
        my($s, $t, $u) = @combination;
        unless($s >= $t || $t >= $u || $s >= $u){
            push @good_triplets, [@{$numbers}[$s, $t, $u]] if(abs($numbers->[$s] - $numbers->[$t]) <= $x && 
                                                              abs($numbers->[$t] - $numbers->[$u]) <= $y &&  
                                                              abs($numbers->[$s] - $numbers->[$u]) <= $z);  

	}
        @combination = $combinations->next_combination;  
        redo if @combination;
    }
    return 0 + @good_triplets;
}

MAIN:{
    say good_triplets([3, 0, 1, 1, 9, 7], 7, 2, 3);
    say good_triplets([1, 1, 2, 2, 3], 0, 0, 1);
}
