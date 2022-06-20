use strict;
use warnings;
##
# Write a script to generate the first 20 Brilliant Numbers.
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

sub is_brilliant{
    my($n) = @_;
    my @factors = prime_factor($n); 
    return @factors == 2 && length($factors[0]) == length($factors[1]);
}

sub n_brilliants{
    my($n) = @_;
    my @brilliants;
    my $i = 0;
    {
       push @brilliants, $i if is_brilliant($i);
       $i++;
       redo if @brilliants < $n;
    }
    return @brilliants;
}

MAIN:{
    print join(", ", n_brilliants(20)) . "\n";
}