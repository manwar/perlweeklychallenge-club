use v5.38;
##
# You are given an array of unique positive integers greater than 2.
# Write a script to sort them in ascending order of the count of their prime factors, 
# tie-breaking by ascending value.
##
sub prime_factor{
    my $x = shift(@_); 
    my @factors;    
    for (my $y = 2; $y <= $x; $y++){
        next if $x % $y;
        $x /= $y;
        push @factors, $y;
        redo;
    }
    return @factors;  
}

sub prime_order{
    my %factor_i = map{($_, 0 + prime_factor($_))} @_;
    my $factor_sorter = sub{
        my $c = $factor_i{$a} <=> $factor_i{$b};
        return $c unless !$c;
        return $a <=> $b;
    };
    return sort $factor_sorter @_;
}

MAIN:{
     say join q/, /, prime_order 11, 8, 27, 4;
}
