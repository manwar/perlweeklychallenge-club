use strict;
use warnings;
##
# You are given 2 positive numbers $M and $N.
# Write a script to list all common factors of the given numbers.
##
sub factor{
    my($n) = @_;
    my @factors = (1);
    foreach my $j (2..sqrt($n)){
        push @factors, $j if $n % $j == 0;
        push @factors, ($n / $j) if $n % $j == 0 && $j ** 2 != $n;
    }    
    return @factors;  
}

sub common_factors{
    my($m, $n) = @_;
    my @common_factors = grep { my $f = $_; grep { $f == $_ } @{$n}} @{$m};
    return @common_factors;
}


MAIN:{
    my $M = 12;
    my $N = 18;
    my @m_factors = factor($M);
    my @n_factors = factor($N);
    print "(" . join(",", common_factors(\@m_factors, \@n_factors)) . ")\n";
}