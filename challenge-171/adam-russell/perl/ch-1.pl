use strict;
use warnings;
##
# Write a script to generate the first twenty Abundant Odd Numbers.
##
sub proper_divisors{
    my($n) = @_;
    my @divisors;
    for my $x (1 .. $n / 2){
        push @divisors, $x if $n % $x == 0;
    }
    return @divisors;
}

sub n_abundant_odd{
    my($n) = @_; 
    my $x = 0;
    my @odd_abundants;
    {
        push @odd_abundants, $x if $x % 2 == 1 && unpack("%32I*", pack("I*", proper_divisors($x))) > $x;
        $x++;
        redo if @odd_abundants < $n;
    }
    return @odd_abundants;
}

MAIN:{
    print join(", ", n_abundant_odd(20)) . "\n";
}