use strict;
use warnings;
##
# Write a script to generate all square-free integers <= 500.
##
use constant LIMIT => 500;

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

sub square_free{
    my @square_free;
    for my $x (1 .. LIMIT){
        my @factors = prime_factor($x);
        my @a;
        map {$a[$_]++} @factors;
        @a = grep {$_ && $_ > 1} @a;
        push @square_free, $x if !@a;
    }
    return @square_free;
}

main:{
    print join(", ", square_free()) . "\n";
}
