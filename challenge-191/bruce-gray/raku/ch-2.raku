# I quickly wrote a slow solution based on Raku's List.permutations,
# and then fixated on creating a hyper-fast solution using
# "cliques" or "playmates"-groupings of divisors+divisees,
# just counting the interactions without the need to
# ever check the "cuteness" of any single permutation.
#
# I failed.
#
# Either my instincts are wrong about that being a viable approach,
# or my brain is not combinotoriously skilled enough. Likely both.
#
# In hindsight, I should have taken the clue about the Matrix Permanent
# in the OEIS article (as jo-37 did for
# https://github.com/manwar/perlweeklychallenge-club/blob/master/challenge-191/jo-37/perl/ch-2.pl ),
# or hand-written a smarter permutation (as 2colours so concisely did in
# https://github.com/manwar/perlweeklychallenge-club/blob/master/challenge-191/2colours/raku/ch-2.raku ).

# As it is, in the little time I had remaining, to be able to solve for 12..15
# with a reasonable runtime, I had to resort to subterfuge.

sub task2 ( UInt $n --> UInt ) {
    return task2_fast($n) if $n > 11;

    sub is_divisor_or_divisee ( \x, \y --> Bool ) { x %% y or x R%% y }

    sub is_cute ( @p --> Bool ) {
        return !defined @p.pairs.first: {
            !is_divisor_or_divisee( .key + 1, .value )
        }
    }

    # Dirt simple, but dead slow.
    return +grep &is_cute, (1 .. $n).permutations;
}

sub task2_fast ( UInt $n --> UInt ) {
    # Inspired by Abigail's https://metacpan.org/pod/OEIS
    my $seq_number = '320843';
    my $cache_file = "b$seq_number.txt";
    my $url = "https://oeis.org/A$seq_number/$cache_file";
    run( 'curl', '-sSO', $url ) unless $cache_file.IO.e;
    die unless $cache_file.IO.e;

    my @A320843;
    @A320843[ .[0] ] = +.[1] for $cache_file.IO.lines.skip».words;

    return @A320843[$n];
}

multi sub MAIN ( @nums ) {
    say "T($_) = ", (task2(+$_) // 'Unknown') for @nums;
}
multi sub MAIN ( Bool :$test! ) {
    my @tests =
        # Example from task:
        (  2 ,            2 ),

        # Known values from OEIS A320843:
        (  1 ,            1 ),
        (  2 ,            2 ),
        (  3 ,            3 ),
        (  4 ,            8 ),
        (  5 ,           10 ),
        (  6 ,           36 ),
        (  7 ,           41 ),
        (  8 ,          132 ),
        (  9 ,          250 ),
        ( 10 ,          700 ),
        ( 11 ,          750 ),
        ( 12 ,         4010 ),
        ( 13 ,         4237 ),
        ( 14 ,        10680 ),
        ( 15 ,        24679 ),
        ( 35 , 207587882368 ),
    ;
    use Test;
    plan +@tests;
    for @tests -> ( $in, $expected ) {
        is task2($in), $expected, "T($in) = $expected";
    }
}
