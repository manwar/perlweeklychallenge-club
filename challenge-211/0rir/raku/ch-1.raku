#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
211-1: Toeplitz Matrix          Submitted by: Mohammad S Anwar
Given a matrix m x n, find out if the given matrix is Toeplitz Matrix.

A matrix is Toeplitz if every diagonal from top-left to bottom-right has
the same elements.

Example 1
Input: @matrix = [ [4, 3, 2, 1],
                   [5, 4, 3, 2],
                   [6, 5, 4, 3],
                 ]
Output: true
Example 2
Input: @matrix = [ [1, 2, 3],
                   [3, 2, 1],
                 ]
Output: false
=end comment

my @Test =
        # shorted
    [ [1,],],                           True,
    [ [1,2,3,4,5,],],                   True,
    [ [1,],[2,],[3,],[4,],[5],],        True,

        # examples
    [ [4,3,2,1], [5,4,3,2], [6,5,4,3],],                True,
    [ [1,2,3], [3,2,1],],                               False,

        # more
    [ [1,1,1,1,], [1,1,1,1,], [1,1,1,1,], [1,1,1,1,],], True,
    [ [1,2],[2,1],],                                    True,
    [ [1,2,3,], [4,1,2,], [5,4,1,],],                   True,
    [ [0,1,2],[1,0,1],[2,1,0],[3,2,1],[4,3,2],],        True,

    [ [9,9,],
      [9,0,],],                 False,

    [ [0,9,],
      [9,9,],],                 False,

    [ [0,1,9],
      [1,0,1],
      [9,1,0],],                True,

    [ [9,1,9],
      [1,0,1],
      [9,1,0],],                False,

    [ [0,9,9],
      [1,0,1],
      [9,1,0],],                False,

    [ [0,1,9],
      [9,0,1],
      [9,1,0],],                False,

    [ [0,1,9],
      [1,9,1],
      [9,1,0],],                False,

    [ [0,1,9],
      [1,0,9],
      [9,1,0],],                False,

    [ [0,1,9],
      [1,0,1],
      [9,9,0],],                False,

    [ [0,1,9],
      [1,0,1],
      [9,1,9],],                False,

    [ [0,2,],
      [1,0,],
      [2,1,],
      [0,2,],],                 True,

    [ [0,1,5,6,],
      [1,0,1,5,],
      [2,1,0,1,],
      [6,2,1,0,],],             True,

    [ [0,1,2,6,],
      [1,0,1,2,],
      [2,1,0,1,],
      [6,2,1,0,],],             True,

    [ [0,1,5,6,7,],
      [1,0,1,5,6,],
      [2,1,0,1,5,],
      [0,2,1,0,1,],],           True,

    [ [0,1,5,6,7,],
      [1,0,1,5,6,],
      [2,1,0,1,5,],
      [0,2,1,0,1,],],           True,
;

my @Dead =
    [ ],
    [ [],],
    [ [1,],[],],
    [ [1,],[1,2],],
    [ [4,3,2,1], [5,4,3,2], [5,4,3],],
;

plan @Test + @Dead;


sub is-toeplitz( @a -->Bool){

    invalid( @a);

    my ($cols, $rows) = @a[0].end, @a.end;

    return True if $cols == 0 or $rows == 0;      # very short diagonals

    my $o = [ $rows-1, 0];

    loop {
        return False unless $o.&diag;
        $o.&next-diag;
        last if $o.&last-diag;
    }
    return True;

    # --- not reached ----

    constant R = 0;
    constant C = 1;

    sub val( $d -->Any){ @a[ $d[R]][ $d[C]] }

    sub next-diag( $d is rw -->Array){  # alter dyad to index next diag origin
        when $d[R] > 0  { --$d[R]; $d }
        when $d[R] == 0 { ++$d[C]; $d }
        die 'not reached ( stupid programmer either way)';
    }

    sub last-diag( $d -->Bool){ $d[R] == 0 and $d[C] == $cols}

    sub diag( $d -->Bool){
        my $ref = $d.&val;
        my ($R, $C) = 1 + $d[R], 1 + $d[C];
        while $R ≤ $rows and $C ≤ $cols {
            return False if $ref ≠ @a[$R++][$C++];
        }
        return True;
    }
    sub invalid( @a -->Nil){
        when @a ~~ Empty {      die "Empty" }
        when @a.any ~~ Empty {  die "Empty elem" }
        with @a[1..^@a].first( {.end !~~ @a[0].end} ) {
                                die "Misshapened"; }
        return;
    }
}

for @Dead -> @in {
    dies-ok { is-toeplitz( @in )},
        "Died-ok: Empty, Empty elem, or misshapened";
}
for @Test -> @in, $exp {
    lives-ok { is-toeplitz( @in )},
        "Lives-ok: Empty, Empty elem, or misshapened";
    is is-toeplitz(@in), $exp, "$exp <- @in.raku()";
}
done-testing;


my @matrix =  [ [0,1,5,6,7,],
                [1,0,1,5,6,],
                [2,1,0,1,5,],
                [0,2,1,0,1,],];

sub matrix-say( @m is copy ) {
    for @matrix -> $row is rw {
        $row = $row.join( ",");
    }
    print "\nInput @matrix = [ [";
    print @matrix.join: "],\n                  [";
    print "],\n                ]\n";
}

matrix-say( @matrix);
say "Output: ", is-toeplitz( @matrix);

exit;

