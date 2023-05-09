#!/bin/env raku

unit sub MAIN(*@stickers);

my %word-bag = @stickers.pop.comb.Bag;
my %bags = @stickers.map({ $_ => .comb.Bag });

if %word-bag.Set (-) ([(|)] %bags.values».Set) {
    put 0;
    exit;
}

my @A = [%word-bag, @stickers.grep({ %bags{$_} (&) %word-bag }), []],;

loop {
    my @A_;

    for @A -> (%word-bag, @stickers, @history) {
        for @stickers -> $s {
            my %word-bag_ = %word-bag (-) %bags{$s};
            my @history_ = |@history, $s;

            if +%word-bag_ == 0 {
                put +@history_;
                exit 0;
            } else {
                @A_.push([%word-bag_, @stickers.grep({ %bags{$_} (&) %word-bag_ }), @history_]);
            }
        }
    }

    @A = @A_;
}
