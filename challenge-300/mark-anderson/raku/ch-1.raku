#/usr/bin/env raku
use Test;

is beautiful-arrangements(2),  2;
is beautiful-arrangements(1),  1;
is beautiful-arrangements(10), 700;

sub beautiful-arrangements($n)
{
    my $result;

    P: for permutations(1..$n) -> $p 
    {
        for 1..$n -> $i
        {
            next P unless any(($p[$i-1] %% $i), ($i %% $p[$i-1]))
        }
       
        $result++
    }

    $result
}
