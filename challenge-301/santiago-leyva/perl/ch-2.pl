=begin
You are given an array of integers, @ints.

Write a script to return the sum of Hamming distances between all the pairs of the integers in the given array of integers.


The Hamming distance between two integers is the number of places in which their binary representations differ.

Example 1
Input: @ints = (4, 14, 2)
Output: 6

Binary representation:
4  => 0100
14 => 1110
2  => 0010

HammingDistance(4, 14) + HammingDistance(4, 2) + HammingDistance(14, 2) = 2 + 2 + 2 = 6.
Example 2
Input: @ints = (4, 14, 4)
Output: 4
=cut

my @ints = ([4, 14, 2],[4, 14, 4]);

foreach (@ints){
    my @arr = @$_;
    my $n = scalar @arr;
    my $HammingDistance = 0;
    for(my $i=0;$i<$n;$i++){
        for(my $j=$i+1;$j<$n;$j++){
            $HammingDistance += HammingDistance($arr[$i],$arr[$j]);
        }
    }
    print "For [",join(" ",@arr),"] Output = $HammingDistance \n";
}

sub HammingDistance {

    my @ints = @_;
    my $distance = 0;
    
    # Find the number of bits required to represent the largest number
    my $max_bits = 0;
    foreach my $num (@ints) {
        $max_bits = length(sprintf("%b", $num)) if length(sprintf("%b", $num)) > $max_bits;
    }
    for my $bit (0 .. $max_bits - 1) {
        my $count_one = 0;
        my $count_zero = 0;

        # Count the number of 1s and 0s in the current bit position for all numbers
        foreach my $num (@ints) {
            if ($num & (1 << $bit)) {
                $count_one++;  # Count how many have a 1 in this bit position
            } else {
                $count_zero++; # Count how many have a 0 in this bit position
            }
        }
        $distance += $count_one * $count_zero;
    }

    return $distance;
}