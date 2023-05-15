#!/usr/bin/raku

sub MAIN(
    $word, *@stickers
) {

    if $word.comb.unique ⊈ @stickers.join.comb.unique {
        say 0;
        exit;
    }
    my @stickerList = (@stickers xx $word.comb.unique.elems).flat;
    my $chars = Bag.new($word.comb);
    my $result = 0;

    LOOP: for 1 .. @stickerList.elems -> $i {
        for @stickerList.combinations($i) -> @combo {
            my $sticker = Bag.new(@combo.join.comb);
            if $chars ⊆ $sticker {
                $result = @combo.elems;
                last LOOP;
            }
        }
    }

    say $result;
}