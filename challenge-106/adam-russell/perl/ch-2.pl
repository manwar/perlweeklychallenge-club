use strict;
use warnings;
##
# You are given numerator and denominator i.e. $N and $D.
# Write a script to convert the fraction into decimal string. 
# If the fractional part is recurring then put it in parenthesis.
##
use boolean;

sub divide{
    my($n, $d) = @_; 
    my @remainders;
    my $q = (int($n / $d)) . ".";
    my $r = $n % $d; 
    push @remainders, $r; 
    my @a;
    for (0 .. $d){
        $q .= int($r*10 / $d);  
        $r = $r*10 % $d;
        @a = grep { $remainders[$_] == $r } (0 .. @remainders - 1);
        last if(@a); 
        push @remainders, $r; 
    }
    my $r_i = $a[0];
    my $i = index($q, ".");
    my $decimal_part = substr($q, $i+1); 
    return substr($q, 0, $i + 1) . substr($decimal_part, 0, $r_i) . "(" . substr($q, $i + $r_i + 1) . ")";  
}   

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

sub nd2decimal{
    my($n, $d) = @_;
    my $max_repetend = $d - 1; 
    my $repeats = false; 
    my @factors = prime_factor($d);
    for my $factor (@factors){
        $repeats = true if($factor != 2 && $factor != 5); 
    } 
    unless($repeats){ 
        return sprintf("%0.${max_repetend}g", $n / $d); 
    }
    else{
        my $x = divide($n, $d, [], []); 
        return $x; 
    }  
}

MAIN:{
    my($N, $D);
    ($N, $D) = (1, 3);
    print nd2decimal($N, $D) . "\n";  
    ($N, $D) = (1, 2);
    print nd2decimal($N, $D) . "\n";  
    ($N, $D) = (5, 66);
    print nd2decimal($N, $D) . "\n";  
    ($N, $D) = (1, 6);
    print nd2decimal($N, $D) . "\n";  
    ($N, $D) = (1, 8);
    print nd2decimal($N, $D) . "\n";  
}
