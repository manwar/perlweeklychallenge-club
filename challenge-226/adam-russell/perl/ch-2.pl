use v5.38;
##
# You are given an array of non-negative integers, @ints.
# Write a script to return the minimum number of operations to make every element equal 
# zero.
##
sub zero_array{
    my $operations = 0;
    do{
        return $operations if 0 == unpack(q/%32I*/, pack(q/I*/, @_));
        my $minimum = (sort { $a <=> $b } grep { $_ > 0 } @_)[0];
        @_ = map { $_ > 0 ? $_ - $minimum : 0 } @_; 
        $operations++;
    } for @_;
}

MAIN:{
    say zero_array 1, 5, 0, 3, 5;
    say zero_array 0;
    say zero_array 2, 1, 4, 0, 3
}