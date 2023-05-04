#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
215-2: Number Placement          Submitted by: Mohammad S Anwar
Given a list of numbers having just 0 and 1, and also a placement count (>=1).

Find if it is possible to replace 0 with 1 in the given list. The only condition is that you can only replace when there is no 1 on either side. Print 1 if it is possible otherwise 0.

Example 1:
Input: @numbers = (1,0,0,0,1), $count = 1
Output: 1

You are asked to replace only one 0 as given count is 1.
We can easily replace middle 0 in the list i.e. (1,0,1,0,1).
Example 2:
Input: @numbers = (1,0,0,0,1), $count = 2
Output: 0

You are asked to replace two 0's as given count is 2.
It is impossible to replace two 0's.
Example 3:
Input: @numbers = (1,0,0,0,0,0,0,0,1), $count = 3
Output: 1
=end comment

my @Test =
    (1,),        1, False,
    (1,1,),      1, False,
    (1,1,1),     1, False,
    (0,0,0),     1, True,
    (0,0,0,0),   1, True,
    (0,0,0,0),   2, False,
    (0,0,0,0,0), 1, True,
    (0,0,0,0,0), 2, True,
    (0,0,0,0,0), 3, False,
    (1,0,0,0),   1, True,
    (0,0,0,1),   1, True,
    (1,0,0,0,1), 1, True,
    (1,0,0,0,1), 2, False,
    (1,0,0,0,0,0,0,0,1), 1, True,
    (1,0,0,0,0,0,0,0,1), 2, True,
    (1,0,0,0,0,0,0,0,1), 3, True,
    (1,0,0,0,0,0,0,0,1), 4, False,
    [1,0,0,0,0,0,0,0,1], 4, False,
;
my @Dead =
    List,           Int,
    List,           1,
    Array,          Int,
    Array,          1,
    (),             Any,
    (),             5,
    [],             2,
    (1,0,0,0,1),    0,
;
plan +@Test ÷ 3 + @Dead ÷ 2;

multi intersperseQ( @a where !@a.DEFINITE, $n -->Bool) { die 'Arg @a undefined'}
multi intersperseQ( @a where * ~~ Empty,   $n -->Bool) { die 'Arg @a empty'}
multi intersperseQ( @a,  Any:D             $n where * < 1 -->Bool)
                                                       { die 'Arg $n invalid'}
multi intersperseQ( @a where *.end < 2,    $n -->Bool) { False }
multi intersperseQ( @a,                    $n -->Bool) {
    my ($ct, $i) = 0, 0;
    while $i <= @a.end - 2 {
        when @a[$i..$i+2].all ~~ 0 {
            return True if ++$ct == $n;
            $i += 2;
        }
        ++$i;
    }
    return False;
}

for @Test -> @in, $n, $exp {
    is intersperseQ( @in, $n), $exp, "$exp\t<= $n into @in[]";
}
for @Dead -> @in, $n {
    dies-ok { intersperseQ( @in, $n)}, "dies '$n.raku()' into '@in.raku()'"
}
done-testing;

my @number = 1,0,0,0,0,0,0,0,1;
my $count = 3;
put "\n\nInput: @number = @number[], \$count = $count\nOutput: ",
        intersperseQ( @number, $count).Int;
exit;
