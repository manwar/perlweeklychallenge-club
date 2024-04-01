sub task2_simple ( Str $word --> UInt  ) {
    return 1 + $word.comb.permutations».join.sort.squish.first( :k, $word );
}

# https://en.wikipedia.org/wiki/Multinomial_theorem#Multinomial_coefficients
sub multinomial_coefficient ( $n, @k1_through_km --> FatRat ) {
    constant @factorial = flat 1, [\*] 1..*;

    my UInt $numer =     @factorial[ $n ];
    my UInt $denom = [*] @factorial[ @k1_through_km ];

    return FatRat.new( $numer, $denom );
}

# https://en.wikipedia.org/wiki/Multinomial_theorem#Number_of_unique_permutations_of_words
# Counting backwards permutations to move each letter to its sorted position.
sub task2_fast ( Str $word --> UInt ) {
    my @letters = $word.comb;
    my %letter_count = @letters.Bag;

    my @ordered_unique_letters = %letter_count.keys.sort;

    my %letter_rank = @ordered_unique_letters.antipairs;

    my $bag = @ordered_unique_letters.map({ %letter_rank{$_} => %letter_count{$_} }).BagHash;

    return 1 + sum gather for @letters.kv -> $i, $letter {
        my $rank = %letter_rank{$letter};
        my $positions_to_go = @letters.end - $i;

        my @blockers = $bag.keys.grep(* < $rank);
        my UInt $positions_blocking = $bag{ @blockers }.sum;

        my FatRat $mc = multinomial_coefficient( $positions_to_go, $bag.values );

        my FatRat $cost_to_move_this_letter = $mc * $positions_blocking;

        # The denominator from multinomial_coefficient() should
        # always have been cancelled out by part of $positions_blocking.
        die "Cannot happen" if $cost_to_move_this_letter.denominator != 1;
        take $cost_to_move_this_letter.narrow;

        $bag{$rank}--;
    }
}

constant @fib = 1, 1, * + * ... Inf;
constant $fib_string = ( ('A'..'G') Zx @fib ).join;

my @tests =
    (   3, 'CAT' ),
    (  88, 'GOOGLE' ),
    ( 255, 'SECRET' ),

    (   1, 'A'       ),
    (   1, 'ABCD'    ),
    (   3, 'BAA'     ),
    (   4, 'BLESS'   ),
    (  28, 'EARTH'   ),
    (  46, 'INDIA'   ),
    (  69, 'MOHAN'   ),
    (  88, 'BRONZE'  ),
    (  93, 'SUPER'   ),
    (  94, 'PRIME'   ),
    (  97, 'COCHIN'  ),
    ( 147, 'BOMBAY'  ),
    ( 331, 'SUCCESS' ),
    ( 354, 'SPEECH'  ),

    (    23, 'UTAH'      ),
    (    83, 'TEXAS'     ),
    (   278, 'OREGON'    ),
    (  4312, 'WYOMING'   ),
    (  6441, 'VIRGINIA'  ),
    ( 41894, 'WISCONSIN' ),

    # Moved to @tests_big: "Cowardly refusing to permutate more than 20 elements, tried 33"
    # (   1,  $fib_string ),
;
my @tests_big =
    (  1648518, 'WASHINGTON'    ),
    (    13737, 'MISSISSIPPI'   ),
    ( 27392274, 'PENNSYLVANIA'  ),
    ( 25371699, 'MASSACHUSETTS' ),

    (                    1, $fib_string      ),
    ( 24017198917263552000, $fib_string.flip ),

    # From ../mark-anderson/raku/ch-2.raku :
    (    2640733527075696, '1100010001100001111100000010101010001101111111111100101' ),
    # Will report 1340132963011393536 if round-off error from Rat->Num failover; FatRat required!
    ( 1340132963011393299, '1100010001100001111100000010101010001101111111111100101011100001' ),
;
constant @subs =
    :&task2_simple,
    :&task2_fast,
;
use Test; plan @tests * @subs + @tests_big;
for @subs -> ( :key($sub_name), :value(&task2) ) {
    my @t = flat( @tests, (@tests_big if $sub_name eq 'task2_fast') );

    for @t -> ( $expected, $in ) {
        is task2($in), $expected, "$sub_name - $in";
    }
}
