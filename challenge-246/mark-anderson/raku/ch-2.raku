#!/usr/bin/env raku
use Test;

ok  linear-recurrence-of-second-order([1,1,2,3,5]);
nok linear-recurrence-of-second-order([4,2,4,5,7]);
ok  linear-recurrence-of-second-order([4,1,2,-3,8]);

sub linear-recurrence-of-second-order(@a)
{
    my @eqn = @a.rotor(3 => -2).head(2);
    my $p = p(@eqn).narrow;
    my $q = q(@eqn.pop, $p).narrow;

    return False unless all($p, $q) ~~ Int;

    my @s = (@a[0], @a[1], -> $a, $b { $a*$p + $b*$q }...*).head(5).Array; 

    @a eqv @s
}
  
sub p(@a)
{
    given @a 
    {
        .[2] / .[0] given .[0] >>*>> .[1;1] >>-<< .[1] >>*>> .[0;1]
    }
}

sub q(@a is copy, $p)
{
    given @a
    {
        .[0] *= $p; 
        (.[2] - .[0]) / .[1]
    }
}
