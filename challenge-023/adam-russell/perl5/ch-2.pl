use Data::Dump q/pp/; 

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

print pp prime_factor(228); 
print pp prime_factor(100); 
print pp prime_factor(110); 

