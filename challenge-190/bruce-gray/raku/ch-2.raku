sub digit_partitions ( UInt $n ) {
    # constant $re = / ^   (.)+ $ /;        # Works.
    # constant $re = / ^ (\d+)+ $ /;        # Faster?
    # constant $re = / ^ (\d ** 1..2)+ $ /; # Faster!

    # Fastest! either of these have the same speed, but have different semantics in other contexts.
    # constant $re = / ^ (1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26)+ $ /;
    constant $re = / ^ (1||2||3||4||5||6||7||8||9||10||11||12||13||14||15||16||17||18||19||20||21||22||23||24||25||26)+ $ /;

    # This fails! But doesn't this doc say it should work?: https://docs.raku.org/language/regexes#Quoted_lists_are_LTM_matches
    # constant @nums = 1 .. 26;
    # constant $re = / ^ (@nums)+ $ /;

    return $n.match( :ex, $re ).map({ .[0].map(~*) });
    # 1. .match(:ex) emits a list of Match objects,
    #    each of which is one of the many ways the RE could match the target.
    # 2. .map processes that list; inside the map $_ is a single Match object.
    # 3. That Match contains, via its .list "view",
    #    a Array of all the parenthsised captures,
    #    .[0] being the first set of lexical parens.
    # 4. `.[0]` accesses the first-and-only set of parens: (\d+)
    # 5. There was a `+` after that set of parens,
    #    so this next level is also an Array of Match objects,
    #    each of which is a cluster of one-or-more digits.
    #    We need each of those to be Numeric instead of Match.
    # 6. `.map` walks that innermost Array,
    #    stringifying the Match in $_ via `~`
}

sub task2 ( Str(Cool) $s ) {
    constant %letters = 1 .. 26 Z=> 'A' .. 'Z';

    my sub joined_letters_if_all_are_valid (@ns) {
        .join if .all.so given %letters{ @ns };
    }

    return sort digit_partitions(+$s).map: &joined_letters_if_all_are_valid;
}

multi sub MAIN ( $input ) { say task2($input) }
multi sub MAIN ( Bool :$test ) {
    my @tests1 =
        (   11, <AA K> ),
        ( 1115, <AAAE AAO AKE KAE KO> ),
        (  127, <ABG LG> ),

        (   222, <BBB BV VB> ),
        (  2222, <BBBB BBV BVB VBB VV> ),
        (  2333, <BCCC WCC> ),
        (  2626, <BFBF BFZ ZBF ZZ> ),
        (  2727, ('BGBG',) ),
    ;
    my @tests2 = q:to/END/.lines;
        I have got 
        such a rotten
        little present
        Misbegotten
        and unpleasant
        Learn your lesson
        Try to leave me
        off your list
        END
    use Test;
    plan +@tests1+@tests2;
    for @tests1 -> ( $input, @expected ) {
        is-deeply task2($input), @expected, "task2($input)";
    }
    sub to_num ( $s ) {
        constant %alpha = 'A'..'Z' Z=> 1..26;
        return %alpha{ $s.comb }.join;
    }
    for @tests2 -> $lyric {
        my $input = $lyric.uc.trans( ' ' => '', "'" => '' );
        my $count = +grep * eq $input, task2(to_num $input);
        is $count, 1, $lyric;
    }
}
