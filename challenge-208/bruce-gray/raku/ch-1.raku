# Four ways-to-do-it; three use `minlist()`.

# `.min` ignores ties, and `.minpairs` has no `:&by` parameter, so `minlist` is needed.
# minlist( <foo bar baz>, :by{ .substr(1,1) } ) returns <bar baz>
sub minlist ( @a, :&by --> List ) {
    return @a[ @a.map(&by).minpairs».key ];
}

# Works with more than 2 lists of words!
sub task1a ( @lists-of-words --> List ) {
    my %word_source_index;
    for @lists-of-words.kv -> $source, @words {
        for      @words.kv -> $index,  $word  {
            %word_source_index{$word}{$source} //= $index;
        }
    }

    return %word_source_index.grep({ .value.elems == @lists-of-words.elems }).&minlist( :by{ .value.values.sum } )».key;
}

sub task1b ( @words1, @words2 --> List ) {
    my %word_source_index;
    %word_source_index{.value}<1> //= .key for @words1.pairs;
    %word_source_index{.value}<2> //= .key for @words2.pairs;

    return %word_source_index.grep({ .value.elems == 2 }).&minlist( :by{ .value.<1 2>.sum } )».key;
}

sub task1c ( @words1, @words2 --> List ) {
    # Reversed to preserve the *first* index of any word duplicated in either array.
    my %h1 = @words1.antipairs.reverse;
    my %h2 = @words2.antipairs.reverse;

    return ( %h1 ∩ %h2 ).keys.&minlist( :by{ %h1{$_} + %h2{$_} } );
}

# Crazy-efficient for early matches, but O(N²) for worst case.
# Instead of `$sum=$i+$j`, this algorithm uses `$j=$sum-$i`.
sub task1d ( @words1, @words2 --> List ) {
    for @words1.keys -> $sum {
        my @r = gather for @words1.head($sum+1).kv -> $i, $word1 {
            my $j     = $sum - $i;
            my $word2 = @words2[$j];

            take $word1 if $word1 eq $word2;
        }
        return @r if @r;
    }
    return Empty;
}


constant @tests =
    ( (<Perl Raku Love> , <Raku Perl Hate> ) , <Perl Raku> ),
    ( ( <A B C>         , <D E F>          ) , List.new    ),
    ( ( <A B C>         , <C A B>          ) , ('A',)      ),
;
use Test;
plan 4 * +@tests;
for @tests -> ( $in, $expected ) {
    is-deeply task1a($in             ).sort, $expected;
    is-deeply task1b($in.[0], $in.[1]).sort, $expected;
    is-deeply task1c($in.[0], $in.[1]).sort, $expected;
    is-deeply task1d($in.[0], $in.[1]).sort, $expected;
}
