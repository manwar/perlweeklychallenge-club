=begin
You are given permutation of $n integers, @ints.

Write a script to find the minimum number of swaps needed to make the @ints a semi-ordered permutation.

A permutation is a sequence of integers from 1 to n of length n containing  each number exactly once.
A permutation is called semi-ordered if the first number is 1 and the last number equals n.
You are ONLY allowed to pick adjacent elements and swap them.

Example 1
Input: @ints = (2, 1, 4, 3)
Output: 2

Swap 2 <=> 1 => (1, 2, 4, 3)
Swap 4 <=> 3 => (1, 2, 3, 4)
Example 2
Input: @ints = (2, 4, 1, 3)
Output: 3

Swap 4 <=> 1 => (2, 1, 4, 3)
Swap 2 <=> 1 => (1, 2, 4, 3)
Swap 4 <=> 3 => (1, 2, 3, 4)
Example 3
Input: @ints = (1, 3, 2, 4, 5)
Output: 0

Already a semi-ordered permutation.

=cut

my @examples = ([2, 1, 4, 3],[2, 4, 1, 3],[1, 3, 2, 4, 5]);

foreach(@examples){
    my @arr = @$_;
    my $result = findMinimum(\@arr);
    print " For [ ",join(" ",@arr)," ] -> $result\n";
}

sub findMinimum {
    my @A = @$_;

    my $small = 1;
    my $big = scalar @A;
    my $swaps = 0;

    return 0 if $A[0] == $small and $A[-1] == $big;

    my ($small_pos,$big_pos); 
    #find where the first value is and the last of the permutation
    for(my $i=0;$i<(scalar @A);$i++){
        if($A[$i] == $small){
            $small_pos = $i+1;
        }
        elsif($A[$i] == $big){
            $big_pos = $i+1;
        }
    }
    my $start = $small_pos;
    #2, 4, 1, 3
    #go left <-
    while($A[0] != $small and $small_pos >1){
        if($A[$small_pos-2] == $big){
            $big_pos = $small_pos -1; #save the last position where the last index was shifted to
        }
        $swaps++;
        ($A[$small_pos-1],$A[$small_pos-2]) = ($A[$small_pos-2],$A[$small_pos-1]);
        $small_pos--;
    }
    #go right from the position where big_pos was shifted to
    while($A[-1] != $big and $big_pos < $big){
        
        $swaps++;
        ($A[$big_pos],$A[$big_pos+1]) = ($A[$big_pos+1],$A[$big_pos]);
        $big_pos++;
    }

    return $swaps;

}