use strict;
use warnings;
##
# Write a script to generate the first 10 Pernicious Numbers.
## 
use Math::Primality qw/is_prime/;

sub count_bits{
    my($n) = @_;
    my $total_count_set_bit = 0;
    while($n){
        my $b = $n & 1;
        $total_count_set_bit++ if $b;
        $n = $n >> 1;
    }
    return $total_count_set_bit;
}

sub first_n_pernicious{
    my($n) = @_;
    my @pernicious;
    my $x = 1;
    do{
        my $set_bits = count_bits($x);
        push @pernicious, $x if is_prime($set_bits);
        $x++;
    }while(@pernicious < $n);
    return @pernicious;
}

MAIN:{
    print join(", ", first_n_pernicious(10)) . "\n";
}