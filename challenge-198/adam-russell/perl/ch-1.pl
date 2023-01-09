use v5.36;
##
# You are given a list of integers, @list.
# Write a script to find the total pairs in the 
# sorted list where 2 consecutive elements has the max gap. 
# If the list contains less then 2 elements then return 0.
##
sub largest_gap{
    my(@numbers) = @_;
    my $gap = -1;
    map{ $gap = $numbers[$_] - $numbers[$_ - 1] if $numbers[$_] - $numbers[$_ - 1] > $gap } 1 .. @numbers - 1;  
    return $gap;
}

sub gap_pairs{
    my(@numbers) = @_;
    return 0 if @numbers < 2; 
    my $gap = largest_gap(@numbers);
    my $gap_count;
    map { $gap_count++ if $numbers[$_] - $numbers[$_ - 1] == $gap } 1 .. @numbers - 1;  
    return $gap_count;

}

MAIN:{
    say gap_pairs(3);    
    say gap_pairs(2, 5, 8, 1);    
}
