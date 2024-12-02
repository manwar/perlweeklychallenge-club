=begin
You are given an array of binary numbers, @binary.

Write a script to return the maximum length of a contiguous subarray with an equal number of 0 and 1.

Example 1
Input: @binary = (1, 0)
Output: 2

(1, 0) is the longest contiguous subarray with an equal number of 0 and 1.
Example 2
Input: @binary = (0, 1, 0)
Output: 2

(1, 0) or (0, 1) is the longest contiguous subarray with an equal number of 0 and 1.
Example 3
Input: @binary = (0, 0, 0, 0, 0)
Output: 0
Example 4
Input: @binary = (0, 1, 0, 0, 1, 0)
Output: 4
=cut

my @binary = ([1, 0],[0, 1, 0],[0, 0, 0, 0, 0],[0, 1, 0, 0, 1, 0]);

# Example usage:
foreach(@binary){
    my @input = @$_;
    my $result = findMaxLength(@input);
    print "For array -> [ ",join(" ",@input)," ] $result\n";
}
sub findMaxLength {
    my @binary = @_; 
    my %sum_map = (0 => -1); 
    my $max_len = 0;  
    my $cum_sum = 0; 
    
    for my $i (0..$#binary) {
        
        $cum_sum += ($binary[$i] == 1) ? 1 : -1;
        
        if (exists $sum_map{$cum_sum}) {
            $max_len = $i - $sum_map{$cum_sum} if $i - $sum_map{$cum_sum} > $max_len;
        } else {
            $sum_map{$cum_sum} = $i;
        }
    }
    return $max_len;
}
