use v5.38;


sub concatenation_value{
    return concatenation_value_r(0, @_);  
}

sub concatenation_value_r{
    return $_[0] if @_ == 1; 
    my $sum = shift;  
    my $l = shift;  
    my $r = pop;  
    return concatenation_value_r($sum + qq/$l$r/, @_) if $l && $r;
    return concatenation_value_r($sum + qq/$l/, @_)   if $l && !$r;
}


MAIN:{
    say concatenation_value 6, 12, 25, 1;         
    say concatenation_value 10, 7, 31, 5, 2, 2;
    say concatenation_value 1, 2, 10;         
}
