use strict;
use warnings;
##
# Write a script to generate the first 20 Achilles Numbers.
##
use POSIX;
use boolean;

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

sub is_achilles{
    my($n) = @_;
    my @factors = prime_factor($n); 
    for my $factor (@factors){
        return false if $n % ($factor * $factor) != 0;
    }
    for(my $i = 2; $i <= sqrt($n); $i++) {
        my $d = log($n) / log($i) . "";
        return false if ceil($d) == floor($d);  
    }
    return true;
}

sub n_achilles{
    my($n) = @_;
    my @achilles;
    my $i = 1;
    {
       $i++;
       push @achilles, $i if is_achilles($i);
       redo if @achilles < $n;
    }
    return @achilles;
}

MAIN:{
    print join(", ", n_achilles(20)) . "\n";
}