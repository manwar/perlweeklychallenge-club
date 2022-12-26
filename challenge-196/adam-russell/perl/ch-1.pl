use v5.36; 
##
# You are given a list of integers, @list.
# Write a script to find the subsequence that respects Pattern 132. 
# Return an empty array if none found.
##
use Data::Dump q/pp/; 
sub pattern_132{
    # i < j < k and a[i] < a[k] < a[j]  
    my @list= @_;
    my @subsequences; 
    for my $i (0 .. @list - 1){
        for my $j (0 .. @list - 1){
            for my $k (0 .. @list - 1){
                push @subsequences, [$list[$i], $list[$j], $list[$k]] if $i < $j && $j < $k && $list[$i] < $list[$k] && $list[$k] < $list[$j];   
            }
        }
    }
    return $subsequences[0];  
}

MAIN:{
    say pp pattern_132(3, 1, 4, 2);  
    say pp pattern_132(1, 3, 2, 4, 6, 5);  
    say pp pattern_132(1, 3, 4, 2);  
}
