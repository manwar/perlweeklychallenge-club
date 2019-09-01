use strict;
use warnings;
##
# Create a script that prints Prime Decomposition of a given number. 
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

MAIN:{
    my $n = $ARGV[0]; 
    print join(", ", prime_factor($n)) . "\n"; 
}
