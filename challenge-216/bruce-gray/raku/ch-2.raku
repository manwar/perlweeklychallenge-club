# We will need three general structures, or set of structures.
# 1. Fixed summary of letters in @stickers
# 2. Mutable info on what letters in $word still need a sticker to contribute.
# 3. All the letters from all the stickers that have been purchased, but not yet used in $word.

# All the letters that have only one source sticker must be handled first (or as a first step on every iteration/recursion)

sub task2 ( @stickers, Str $word --> UInt ) {
    return 0 if $word.comb.Set (-) @stickers».comb.flat.Set;

    my BagHash $word_letters = $word.comb.BagHash;

    # my @sticker_letters = @stickers.map: *.comb.Bag;
    my @sticker_letters = @stickers.map: *.comb.grep({ $word_letters{$_} }).Bag; # Reduces to just useful letters

    my %letter_sources; # XXX Change to build via a multi-level .classify or .categorize?
    my %letter_source_count;
    for @sticker_letters.kv -> UInt $index, Bag $sl {
        for $sl.kv -> Str $letter, UInt $count {
            warn if defined %letter_sources{$letter}[$index];
            %letter_sources{$letter}[$index] = $count;
            %letter_source_count{$letter}++;
        }
    }

    my %letter_single_source;
    for %letter_sources.kv -> Str $letter, @source_counts {
        my @indexes = @source_counts.pairs.grep(*.value.defined)».key;
        %letter_single_source{$letter} = @indexes.head if @indexes == 1;
    }

    my UInt    $stickers_bought = 0;
    my BagHash $bought_unused_letters;
    sub buy ( UInt $index --> Nil ) {
        my Bag $b = @sticker_letters[$index]
            orelse die "Cannot happen";
        $bought_unused_letters{$_} += $b{$_} for $b.keys;
        $stickers_bought++;
    }

    sub use_up_all ( --> Nil ) {
        for $bought_unused_letters.kv -> Str $letter, UInt $have {
            my UInt $need  = $word_letters{$letter}
                or next;
            my UInt $using = [min] $have, $need;

            $bought_unused_letters{$letter} -= $using;
            $word_letters{         $letter} -= $using;
        }
    }

    sub buy_all_single_source_stickers ( --> Nil ) {
        loop {
            my $letter = $word_letters.keys.sort.first({ %letter_single_source{$_}.defined })
                orelse return;

            my $index  = %letter_single_source{$letter};
            buy( $index );
            use_up_all();
        }
    }
    buy_all_single_source_stickers();

    return $stickers_bought if not $word_letters;

    # Past this point, the problem deserves a better algorithm.
    # At the very least, I should run an analysis to allow selecting `$target_letter`
    # based on count of stickers needed instead of count of letters needed.
    # However, I am out of time for this week.
    warn "The answer you are about to get might not be the minimum possible";

    # At this point, all remaining letters have multiple sources.
    while $word_letters {
        my ($target_letter, $target_count) = $word_letters.max(*.value).kv;
        my ($next_sticker_index, $next_sticker_letter_count) = %letter_sources{$target_letter}.pairs.max({.value // 0}).kv;
        my $quantity_to_buy = ( $target_count / $next_sticker_letter_count ).ceiling;
        buy($next_sticker_index) for ^$quantity_to_buy;
        use_up_all();
    }

    return $stickers_bought;
}

my @tests =
    ( <perl raku    python> , 'peon'          , 2 ),
    ( <love hate    angry>  , 'goat'          , 3 ),
    ( <come nation  delta>  , 'accommodation' , 4 ),
    ( <come country delta>  , 'accommodation' , 0 ),

    ( <come nation  delta>  , 'accommodationoooooooooooo' , 16 ),
;
use Test;
plan +@tests;
for @tests -> ( $in_stickers, $in_word, $expected ) {
    is    task2($in_stickers, $in_word),$expected;
}
