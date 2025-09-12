#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.e.PREVIEW;
use Test;

=begin comment
337-2: Odd Matrix
Submitted by: Mohammad Sajid Anwar
You are given row and col, also a list of positions in the matrix.

Write a script to perform action on each location (0-indexed) as provided in the list and find out the total odd valued cells.

For each location (r, c), do both of the following:

a) Increment by 1 all the cells on row r.
b) Increment by 1 all the cells on column c.

Example 1
Input: $row = 2, $col = 3, @locations = ([0,1],[1,1])
Output: 6

Initial:
[ 0 0 0 ]
[ 0 0 0 ]

Apply [0,1]:
Increment row 0:
Before     After
[ 0 0 0 ]  [ 1 1 1 ]
[ 0 0 0 ]  [ 0 0 0 ]
Increment col 1:
Before     After
[ 1 1 1 ]  [ 1 2 1 ]
[ 0 0 0 ]  [ 0 1 0 ]

Apply [1,1]:
Increment row 1:
Before     After
[ 1 2 1 ]  [ 1 2 1 ]
[ 0 1 0 ]  [ 1 2 1 ]
Increment col 1:
Before     After
[ 1 2 1 ]  [ 1 3 1 ]
[ 1 2 1 ]  [ 1 3 1 ]

Final:
[ 1 3 1 ]
[ 1 3 1 ]

Example 2
Input: $row = 2, $col = 2, @locations = ([1,1],[0,0])
Output: 0

Example 3
Input: $row = 3, $col = 3, @locations = ([0,0],[1,2],[2,1])
Output: 0

Example 4
Input: $row = 1, $col = 5, @locations = ([0,2],[0,4])
Output: 2

Example 5
Input: $row = 4, $col = 2, @locations = ([1,0],[3,1],[2,0],[0,1])
Output: 8
=end comment

=begin comment
    Accepting the implied instruction to create a matrix of zeros.
=end comment

my @Test =
    2,  3,  ([0,1],[1,1]),              6,
    2,  2,  ([1,1],[0,0]),              0,
    3,  3,  ([0,0],[1,2],[2,1]),        0,
    1,  5,  ([0,2],[0,4]),              2,
    4,  2,  ([1,0],[3,1],[2,0],[0,1]),  8,
;

plan +@Test ÷ 2;

sub task-naive( \row, \col, @loca -->Int) {
    my @m = [ $(False) xx row] xx col;
    my @work;

    # Delete smartly matching couples of @loca elems from work to do.
    my @xy = @loca.sort;
    while @xy > 1 {
        if @xy[0] ~~ @xy[1] { sink        @xy.shift xx 2; }
        else                { @work.push: @xy.shift     ; }
    }
    @work.push: @xy.shift;

    for @work -> (\r,\c) {
        @m[r;^col].=map: ! *;        # TODO how-to? assign slices of shaped.
        @m[^row;c].=map: ! *;
    }
    + @m.flat(:hammer).grep: ? *;
}

sub task-accum( $row, $col, @loca -->Int) {
    my %accum;

    the-chosen( $_) for @loca;
    return +%accum.values.grep( so *);

                    # Encode key for %accum
                sub id( \x, \y --> Str:D) { x ~ ':' ~ y }

                    # To cache true locations in %accum 
                sub the-chosen( @l ( \r,\c) --> Array:D ) {
                    %accum{id $_, c} = ! %accum{id $_, c}  for ^$row;
                    %accum{id r,$_ } = ! %accum{id r,$_ }  for ^$col;
                }
}

for @Test -> \r, \c, @loca, \exp {
    is task-naive( r,  c, @loca),  exp,
            "{exp // exp.^name()} <- {r}x{c} ∘∘ @loca.raku()";
    is task-accum( r,  c, @loca),  exp, "task-accum";
}
done-testing;

my $r = 4;
my $c = 2;
my @location = [1,0],[3,1], [2,0], [1,0];


say "\nInput: \$row = $r, \$col = $c, @locations = @location.raku()\n"
  ~ "Output: {task-accum $r, $c, @location}";

