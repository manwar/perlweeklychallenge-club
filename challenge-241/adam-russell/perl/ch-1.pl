use v5.38;
##
# You are given an array (3 or more members) of integers in increasing order and a 
# positive integer. Write a script to find out the number of unique Arithmetic Triplets 
# satisfying the following rules:
# a) i < j < k
# b) nums[j] - nums[i] == diff
# c) nums[k] - nums[j] == diff
##
sub arithmetic_triplets{
    my $counter = 0;
    my $difference = shift;
    arithmetic_triplets_r($difference, \$counter, [@_[0 .. @_ -1]], [@_[1 .. @_ -1]], [@_[2 .. @_ -1]]);   
    return $counter;
} 

sub arithmetic_triplets_r{
    my $difference = $_[0]; 
    my $counter = $_[1]; 
    my @i = @{$_[2]};         
    my @j = @{$_[3]};         
    my @k = @{$_[4]};        
    if(@i > 0 && @j > 0 && @k > 0){
        $$counter++ if $j[0] - $i[0] == $difference && $k[0] - $j[0] == $difference;   
        arithmetic_triplets_r($difference, $counter, [@i], [@j], [@k[1 .. @k - 1]]);   
    }
    elsif(@i > 0 && @k == 0 && @j > 0){
        arithmetic_triplets_r($difference, $counter, [@i], [@j[1 .. @j - 1]], [@j[2 .. @j - 1]]);   
    }
    elsif(@i > 0 && @k == 0 && @j == 0){
        arithmetic_triplets_r($difference, $counter, [@i[1 .. @i - 1]], [@i[2 .. @i - 1]], [@i[3 .. @i - 1]]);   
    }
}

MAIN:{
    my $difference;
    $difference = 3;
    say arithmetic_triplets $difference, 0, 1, 4, 6, 7, 10;
    $difference = 2;
    say arithmetic_triplets $difference, 4, 5, 6, 7, 8, 9;  
}
