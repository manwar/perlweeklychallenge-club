#!/usr/bin/env raku
use Test;

for &trionic-array, &trionic-array-v2 
{
    ok  .(1,3,5,4,2,6,8);
    nok .(1,4,4,2,1,3,5);
    ok  .(2,10,3,1,9);
    nok .(1,2,3,4,3,2,1);
    nok .(1,3,6,4,2,7,8,4);
    nok .(1,2,3,4);
    nok .(4,3,2,1);
    ok  .(1,2,1,2)
}

sub trionic-array(*@n)
{
    @n.rotor(2 => -1)
      .map({ (.[1] - .[0]).sign })
      .join
      .match(/^ 1+ '-1'+ 1+ $/)
}

sub trionic-array-v2(*@n)
{
    my $a = quietly ([\<] @n).first(*.not, :k) - 1; 
    return  False if $a == 0|-1;

    my $b = quietly ([\>] @n[$a..*]).first(*.not, :k) - 1;
    return  False if $b == 0|-1;

    return  False unless [<] @n[$a+$b..*];
    return  True
}
