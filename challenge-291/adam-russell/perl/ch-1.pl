use v5.40;

sub sum_list{
    return unpack("%I*", pack("I*", @_));  
}

sub middle_index{
    for my $i (0 .. @_ - 1){  
        return $i if sum_list(@_[0 .. $i - 1]) == sum_list(@_[$i + 1 .. @_ - 1]); 
    } 
    return -1;  
}

say middle_index 2, 3, -1, 8, 4; 
say middle_index 1, -1, 4; 
say middle_index 2, 5; 
