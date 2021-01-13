use strict;
use warnings;
##
# You are given a positive integer $N.
# Write a script to find out all possible combination 
# of Fibonacci Numbers required to get $N on addition.
# Repeated numbers are not allowed. Print 0 if none found.
##
sub nearest_fibonacci{
    my($n) = @_;
    my @f = (1, 1);
    while($f[@f - 1] <= $n){
        my $f = $f[@f - 1] + $f[@f - 2];
        push @f, $f;
    }
    pop @f;
    return @f;
}

sub fibonacci_sum{
    my($n, $fibonacci) = @_;
    my @sum_terms;
    my $number_terms = @{$fibonacci}; 
    for my $i (0 .. (2**$number_terms - 1)){
        my $b = sprintf("%0" . $number_terms . "b", $i); 
        my @b = split(//, $b);
        my @f;
        for my $i (0 .. (@b - 1)){
            push @f, $fibonacci->[$i] if $b[$i] == 1;
        }
        my $sum = unpack("%32I*", pack("I*", @f)); 
        push @sum_terms, \@f if $sum == $n;
    }
    return @sum_terms;
}

MAIN:{
    my $n = $ARGV[0];
    my @f = nearest_fibonacci($n);
    my @sum_terms = fibonacci_sum($n, \@f);
    print "No Fibonacci Terms sum to $n.\n" if !@sum_terms;
    for my $term (@sum_terms){
        print join(" + ", @{$term}) . " = $n\n";
    }
}