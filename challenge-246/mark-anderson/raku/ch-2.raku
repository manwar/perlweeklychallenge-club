#!/usr/bin/env raku
use Math::Matrix;
use Test;

# Disclaimer: This might be totally wrong but it seems right.

ok  task2(1,1,2,3,5);
nok task2(4,2,4,5,7);
ok  task2(4,1,2,-3,8);

sub task2(*@a)
{
    my @equations = @a.rotor(3 => -2);
    
    my ($p1,$q1) = p-and-q(@equations[0], @equations[1]);
    my ($p2,$q2) = p-and-q(@equations[1], @equations[2]);

    return False unless ($p1,$q1,$p2,$q2)>>.narrow.all ~~ Int;
    return ($p1,$q1) eqv ($p2,$q2)
}
  
sub p-and-q(@a, @b)
{
    my $A = Math::Matrix.new([[@a.head(2), @b.head(2)]]);
    my $B = Math::Matrix.new([[@a.tail], [@b.tail]]);
    |$A.inverted.dot-product($B)
}
