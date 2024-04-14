#!/usr/bin/env rak;
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ;
use v6;
use Test;

=begin comment
264-2: Target Array         Submitted by: Mohammad Sajid Anwar
You are given two arrays of integers, @source and @indices. The @indices can only contains integers 0 <= i < size of @source.

Write a script to create target array by insert at index $indices[i] the value $source[i].

Example 1
Input: @source  = (0, 1, 2, 3, 4)
       @indices = (0, 1, 2, 2, 1)
Output: (0, 4, 1, 3, 2)

@source  @indices  @target
0        0         (0)
1        1         (0, 1)
2        2         (0, 1, 2)
3        2         (0, 1, 3, 2)
4        1         (0, 4, 1, 3, 2)
Example 2
Input: @source  = (1, 2, 3, 4, 0)
       @indices = (0, 1, 2, 3, 0)
Output: (0, 1, 2, 3, 4)

@source  @indices  @target
1        0         (1)
2        1         (1, 2)
3        2         (1, 2, 3)
4        3         (1, 2, 3, 4)
0        0         (0, 1, 2, 3, 4)
Example 3
Input: @source  = (1)
       @indices = (0)
Output: (1)

=end comment

my @Test =
    # source                indices             resul;
    (0, 1, 2, 3, 4),        (0, 1, 2, 2, 1),    (0, 4, 1, 3, 2),
    (1, 2, 3, 4, 0),        (0, 1, 2, 3, 0),    (0, 1, 2, 3, 4),
    (1,),                    (0,),                (1,),
    (4, 3, 2, 1),           (0, 0, 0, 0),       (1, 2, 3, 4),
    (4, 3, 2, 1),           (0, 0, 0, 1),       (2, 1, 3, 4),
    (4, 3, 2, 1),           (0, 0, 1, 0),       (1, 3, 2, 4),
;
my @Dimmed-test =
    (4, 3, 2, 1),           (1, 0, 0, 0),       (1, 2, 3, 4),
    (4, 3, 2, 1),           (2, 0, 0, 0),       (1, 2, 3, 4),
    (4, 3, 2, 1),           (3, 0, 0, 0),       (1, 2, 3, 4),
    (4, 3, 2, 1),           (3, 2, 0, 0),       (1, 2, 3, 4),
    (4, 3, 2, 1),           (2, 0, 3, 0),       (1, 3, 4, 2),
;
plan (@Test × 2 + @Dimmed-test) ÷ 3;

# unconstrained arrays
sub splice-one-in( @list, $start, $new-value --> Array ) {
    sink splice(@list, $start, 0, $new-value);
    @list;
}

sub reindex( @value, @splice-idx -->Array) {
    my @ret;
    for ^@splice-idx -> \i {
        splice-one-in @ret, @splice-idx[i], @value[i];
    }
    @ret;
}


# shaped arrays allow starting anywhere
sub insert( @s, Any:D $value, Any(Int) $loca ) {
    without @s[$loca] {
        @s[$loca] = $value;
        return;
    }
    my $k = @s[ (1 + $loca)..^@s].first( ! *.defined, :k);  # 'empty' index
    die "ERROR inserting $value at $loca; cannot move occupant."
        without $k;
    $k += $loca + 1;    # adjust for with slice's offset
    @s[ $loca..$k] = flat $value, @s[$loca..^$k];   # insert w/ moving others
    return;
}

sub shaped-reindex( @value, @index -->Array) {
    my @ret[ @value.elems];
    for ^@index -> \i {
        insert @ret,  @value[i], @index[i];
    }
    @ret;
}

for @Test -> $source, $splice-dest, $exp {
   is reindex($source, $splice-dest), $exp, "$exp <- $source « $splice-dest";
   is shaped-reindex($source, $splice-dest), $exp,
        "$exp <- $source.raku() « $splice-dest.raku() shaped";
}
for @Dimmed-test -> $source, $splice-dest, $exp {
   is shaped-reindex($source, $splice-dest), $exp,
        "$exp <- $source.raku() « $splice-dest.raku() shaped";
}

done-testing;

exit;

