# Simple, but two passes:
# sub max_list ( @a, &c ) {
#     my $max = @a.map(&c).max;
#     return @a.grep( *.&c == $max );
# }

# Single-pass:
sub max_list ( Iterable $a, Code $c ) {
    my ( $max, @r );
    for $a.list -> $aa {
        my $cc = $aa.$c;
        $max //= $cc;
        given $cc cmp $max {
            when Order::More { @r   =   $aa; $max = $cc; }
            when Order::Same { @r.push: $aa;             }
            when Order::Less {} # Do nothing
        }
    }
    return @r;
}

# Concise, but not better eough to get away from the literal task definition.
# sub valid_triangle_sides ( @abc where *.elems == 3 --> Bool ) {
#     return @abc.permutations.map(-> (\a, \b, \c) { a + b > c }).all.so;
#     return @abc.permutations.map({ .[0,1].sum > .[2] }).all.so;
# }

sub valid_triangle_sides ( (\a, \b, \c) --> Bool ) {
    return a + b > c
        && b + c > a
        && a + c > b;
}
sub task2 ( @a ) {
    # XXX .combinations does not allow for early exit on $c! So, non-optimal.
    my @r = @a.sort(-*).combinations(3).grep(&valid_triangle_sides);

    return @r.&max_list({ .sum }).first({ [≥] .list }) // ();
}


constant @fibonacci     = ( 1, 1, * + * ... * ).head(50);
constant @powers_of_2   = (    1, * * 2 ... * ).head(50);
constant @powers_of_2_4 = 1, 4, 4, |@powers_of_2.skip(3);
constant @powers_of_2_1 = @powers_of_2.skip(1) X- 1;

# From: raku -e 'my @a = (1..^10_000).roll(100); say @a.join(",")'
constant @random_100    = 8188,203,44,2634,2658,603,6912,6292,1518,1047,2341,9358,1238,2154,8715,8558,8550,7253,2547,8800,780,4020,2352,5863,6057,7497,8296,6641,8653,3654,5314,9072,8029,6522,8388,8789,9762,4265,79,7714,9014,8671,3385,9961,4078,6256,6311,5816,1790,1396,8631,7488,4469,9897,1419,6340,957,7876,3604,3218,5495,9876,5696,3233,1635,9845,7164,6546,228,3824,2862,8065,8251,9521,5043,7813,2189,6273,7870,7947,2526,5706,6751,4350,1199,8915,9397,4398,9245,3916,7977,2749,3944,8073,3410,1617,9150,7324,8374,4776;


my @tests =
    # Original examples from TWC 187:
    ( :Ex1(1, 2, 3, 2) , (3, 2, 2) ),
    ( :Ex2(1, 3, 2)    , ()        ),
    ( :Ex3(1, 1, 2, 3) , ()        ),
    ( :Ex4(2, 4, 3)    , (4, 3, 2) ),

    # Extra tests, by author:
    ( :Short(2, 4)          , ()        ),
    ( :@powers_of_2         , ()        ),
    ( :@powers_of_2_4       , (4, 4, 1) ),
    ( :@powers_of_2_1       , ()        ),
    ( :@fibonacci           , ()        ),
    ( :@random_100, @random_100.sort(-*).head(3) ),
    
;
use Test;
plan +@tests;
for @tests {
    my ( $name, $input, $expected ) = .[0].key, .[0].value, .[1];
    is-deeply task2($input), $expected, $name;
}
