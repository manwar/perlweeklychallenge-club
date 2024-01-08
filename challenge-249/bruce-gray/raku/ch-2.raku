# Here you can see the evolution of my thinking of the problem,
# and the resulting changes in my solutions.

# Used by one solution, and to test for validity.
sub perm_to_DI ( @perm --> Str ) {
    my Bool @up = @perm Z< @perm.skip;
    return <D I>[@up].join;
}

# There are many solutions to most inputs; DID could be any of <1032 2031 2130 3021 3120>.
# Choice of D/I will produce 2ⁿ possibilities, but permutations will be N!.
# This can easily generate all of them for analysis; it just returns the first one found.
# Either way, it will fail to deliver the particular solution given in the task.
sub task2_many ( Str $s ) {
    my @a = 0 .. $s.chars;
    return @a.permutations.first({ .&perm_to_DI eq $s });

    # my @answers = @a.permutations.grep({ .&perm_to_DI eq $s });
    # return @answers.tail;
}

# Popping and shifting from ends works well.
sub task2b ( Str $s ) {
    my @a = 0 .. $s.chars;
    my @ret;
    for $s.comb -> $D_I {
        push @ret, ($D_I eq 'D') ?? (@a.pop)
                !! ($D_I eq 'I') ?? (@a.shift)
                !!                  die
                ;
    }
    warn if @a != 1; # Only one should be left.
    push @ret, @a.shift;
    return @ret.List;
}

# If we add `D` or `I` to the end, we don't need the final shift/pop!
sub task2c ( Str $s ) {
    my @a = 0 .. $s.chars;
    return "{$s}I".comb.map: {
            $_ eq 'D' ?? @a.pop
         !! $_ eq 'I' ?? @a.shift
         !!              die;
    }
}

# Hmmm. Could I sweep once and deposit numbers forward for every I, then reverse and deposit for D?
# Could I classify the index based on D/I? Yes! Works!
sub task2d ( Str $s ) {
    my @aa = 0 .. $s.chars;
    my %DI = "{$s}I".comb.pairs.classify( *.value, :as{.key} );

    my @ret;
    @ret[ %DI<I>.list ] = @aa.splice(0, %DI<I>.elems)         if %DI<I>;
    @ret[ %DI<D>.list ] = @aa.splice(0, %DI<D>.elems).reverse if %DI<D>;
    return @ret;
}

# Tighter.
sub task2e ( Str $s ) {
    my ( $D, $I ) = "{$s}I".comb.pairs.classify( *.value eq 'D', :as{.key} ){True, False};
    my @ret;
    @ret[ $I.list ] =       0 ..^ $I.elems                 if $I;
    @ret[ $D.list ] = $s.chars … ($s.chars - $D.elems + 1) if $D;
    return @ret;
}

# Different.
sub task2f ( Str $s ) {
    my ( $D, $I ) = "{$s}I".comb.pairs.classify( *.value eq 'D', :as{.key} ){True, False}.map({ $_ // [] });
    my @ret;
    @ret[ $I.list ] =       0 ..^ $I.elems;
    @ret[ $D.list ] = $s.chars … ($s.chars - $D.elems + 1);
    return @ret;
}

# Going back to task2c, and realizing that we don't need the whole array when we are only using the endpoints.
# Best solution!
sub task2g ( Str $s ) {
    my ($lo, $hi) = 0, $s.chars;

    return "{$s}I".comb.map({ $_ eq 'D' ?? $hi-- !! $lo++ });
}


my @tests =
    ( 'IDID' , (0, 4, 1, 3, 2) ),
    ( 'III'  , (0, 1, 2, 3) ),
    ( 'DDI'  , (3, 2, 0, 1) ),
;
constant @subs =
    :&task2_many
    :&task2b,
    :&task2c,
    :&task2d,
    :&task2e,
    :&task2f,
    :&task2g,
;
use Test; plan @subs * @tests * 2;
for @subs -> ( :key($sub_name), :value(&task2) ) {
    for @tests -> ( $in, @expected ) {
        is-deeply task2($in).List, @expected, "$sub_name: $in";

        is-deeply perm_to_DI(@expected), $in, "$sub_name: $in round-trip";
    }
}
