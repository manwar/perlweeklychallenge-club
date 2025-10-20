#!/usr/bin/env raku
use Test;

ok  array-formation([[2,3],[1],[4]], [1,2,3,4]);
nok array-formation([[1,3],[2,4]], [1,2,3,4]);
ok  array-formation([[9,1],[5,8],[2]], [5,8,2,9,1]);
nok array-formation([[1],[3]], [1,2,3]);
ok  array-formation([[7,4,6]], [7,4,6]);
ok  array-formation([[1],[2,33],[33,4],[2,33,4,5],[7],[1,2]],
                    [1,2,33,4,5,7,33,4,2,33,1,2]);

sub array-formation(@source, @target)
{
    my $target = @target.Str;

    for @source.sort(-*.elems) 
    {
        $target .= subst(/$_/, 'X');
        return False unless $/
    }

    $target !~~ /<digit>/
}
