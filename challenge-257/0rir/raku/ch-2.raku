#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
257-2: Reduced Row Echelon           Submitted by: Ali Moradi

Given a matrix M, check whether the matrix is in reduced row echelon form.

A matrix must have the following properties to be in reduced row echelon form:

1. If a row does not consist entirely of zeros, then the first
   nonzero number in the row is a 1. We call this the leading 1.
2. If there are any rows that consist entirely of zeros, then
   they are grouped together at the bottom of the matrix.
3. In any two successive rows that do not consist entirely of zeros,
   the leading 1 in the lower row occurs farther to the right than
   the leading 1 in the higher row.
4. Each column that contains a leading 1 has zeros everywhere else
   in that column.

For example:

[
   [1,0,0,1],
   [0,1,0,2],
   [0,0,1,3]
]
The above matrix is in reduced row echelon form since the first nonzero number in each row is a 1, leading 1s in each successive row are farther to the right, and above and below each leading 1 there are only zeros.

For more information check out this wikipedia article.

Example 1
    Input: $M = [
                  [1, 1, 0],
                  [0, 1, 0],
                  [0, 0, 0]
                ]
    Output: 0
Example 2
    Input: $M = [
                  [0, 1,-2, 0, 1],
                  [0, 0, 0, 1, 3],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0]
                ]
    Output: 1
Example 3
    Input: $M = [
                  [1, 0, 0, 4],
                  [0, 1, 0, 7],
                  [0, 0, 1,-1]
                ]
    Output: 1
Example 4
    Input: $M = [
                  [0, 1,-2, 0, 1],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 1, 3],
                  [0, 0, 0, 0, 0]
                ]
    Output: 0
Example 5
    Input: $M = [
                  [0, 1, 0],
                  [1, 0, 0],
                  [0, 0, 0]
                ]
    Output: 0
Example 6
    Input: $M = [
                  [4, 0, 0, 0],
                  [0, 1, 0, 7],
                  [0, 0, 1,-1]
                ]
    Output: 0

=end comment

my @Test =
    # $M        out
    [ [0], [0], [0] ],                                  True,
    [ [0,0,0], [0,0,0], [0,0,0], [0,0,0] ],             True,
    [ [0,0,0], [0,0,0], [0,0,0], [0,0,1] ],             False,
    [ [0, 1,-2, 0, 1], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0] ],
            True,
    [ [1,0,0], [0,1,0], [0,0,1], [0,0,0] ],             True,
    [ [1,0,0], [0,1,0], [0,0,1], [0,0,1] ],             False,
    [ [1,0,1,1], [0,0,1,5], [0,0,0,0] ],                False,

    [ [0, 1,-2, 0, 1], [0, 0, 0, 1, 1], [0, 0, 0, 0, 1], [0, 0, 0, 0, 0] ],
            False,
    [ [1, 1, 0], [0, 1, 0], [0, 0, 0] ],            False,
    [ [0, 1,-2, 0, 1], [0, 0, 0, 0, 0], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0] ],
    False,
    [ [0, 1, 0], [1, 0, 0], [0, 0, 0] ],
    False,
    [ [4, 0, 0, 0], [0, 1, 0, 7], [0, 0, 1,-1] ],   False,
    [ [1, 0, 0, 4], [0, 1, 0, 7], [0, 0, 1,-1] ],   True,
;

my @Die =
    [],
    [[],],
    [ [0,0], [0,0,0],]
;
plan @Test ÷ 2 + @Die;

multi func( @a where *     ~~ Empty) { die 'Empty matix.' }
multi func( @a where @a[0] ~~ Empty) { die 'Matix of Empty.' } # not Whatever
multi func( @a, $state? -->Bool) {
    die 'Not a matrix.' unless @a[0].end == all @a[0..^@a]».end;
    my $prev-first = -1;        # last index for valid leading non-zed
    my @leader-col;             # index of columns w/ valid leading non-zed
    my $idx = 0;                # current work row

    for ^@a -> $i {         # check row by row
        my @row := @a[$i];
        my $k = @row.first: * ≠ 0, :k;

        if $k.defined {
            return False if @row[$k] ≠ 1;       # invalid 1st non-zed elem
            return False if $k ≤ $prev-first;   # stair broken
            $prev-first = $k;
            @leader-col.push: $k;      # collect columns with non-zed leaders
            return True if $i == @a.end;
        } else {
            $idx = $i;
            last;
        }
    }
            # hit an all zed row at $idx
    for 1+$idx..^@a {
        return False if @a[$_].first( * ≠ 0, :k ).defined;   # all-zed ! at end
    }
            # row issues done
    my @col = ( ( [Z] @a)>>.Array).Array;                   # rotate

        # fail if a leader column has multiple ones
    return False if +@col[@leader-col].grep( { + .grep( * == 1 ) ≠ 1  });

    True 
}


for @Test -> @in, $exp {
    is func(@in), $exp, "$exp <- @in.raku()";
}

for @Die -> @in {
    dies-ok { func(@in)}, "@in.raku() dies ok";
}

done-testing;
my $M = [ [4, 0, 0, 0], [0, 1, 0, 7], [0, 0, 1,-1] ];

say "\n    Input: \$M = [\n&rprint(12, @$M)"
   ~"          ]\n    Output: &func(@$M)";

sub rprint( Int $indent, @a -->Str) {
    my $s;
    for @a -> @r {
        $s ~= " " x $indent ~ @r.raku ~ "\n" ;
    }
    $s;
}
exit;

