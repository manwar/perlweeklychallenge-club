#!/usr/bin/env raku
use Test;

ok  array-formation([[2,3],[1],[4]], [1,2,3,4]);
nok array-formation([[1,3],[2,4]], [1,2,3,4]);
ok  array-formation([[9,1],[5,8],[2]], [5,8,2,9,1]);
nok array-formation([[1],[3]], [1,2,3]);
ok  array-formation([[7,4,6]], [7,4,6]);
ok  array-formation([[1,2,3],[4],[5,6],[1,2],[3,4,5]], [1,2,3,4,5,1,2,3,4,5,6]), "E Choroba Test";

sub array-formation(@source, @target)
{
    my $target = @target.Str;

    outer: for [X] @source.map({ 1..$target.match(/$_/, :g) }) -> $list
    {
        { 
            temp $target;
            
            for $list.kv -> $k,$v
            {
                $target .= subst(/"@source[$k]"/, 'X', :nth($v));
                next outer unless $/
            }
   
            return True unless $target ~~ /<digit>/
        }
    }

    return False
}
