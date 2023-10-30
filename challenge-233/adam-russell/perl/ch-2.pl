use v5.38;
##
# You are given an array of integers.
# Write a script to sort the given array in increasing order based on the frequency of the 
# values. If multiple values have the same frequency then sort them in decreasing order.
##
sub frequency_sort{
    my(@numbers) = @_;
    my %frequency;
    do{$frequency{$_}++} for @numbers;
    my $frequency_sorter = sub{
        my $c = $frequency{$a} <=> $frequency{$b};
        return $c unless !$c;
        return $b <=> $a;
        
    };
    return sort $frequency_sorter @numbers;
}

MAIN:{
    say join q/, /, frequency_sort 1, 1, 2, 2, 2, 3;
    say join q/, /, frequency_sort 2, 3, 1, 3, 2;
    say join q/, /, frequency_sort -1, 1, -6, 4, 5, -6, 1, 4, 1
}