#!/usr/bin/env raku
use Test;

is word-stickers(<perl raku python>,                            <peon>),                               2;
is word-stickers(<love hate angry>,                             <goat>),                               3;
is word-stickers(<come nation delta>,                           <accommodation>),                      4;
is word-stickers(<come country delta>,                          <accommodation>),                      0;
is word-stickers(<come accommodations country delta>,           <accommodation>),                      1;
is word-stickers(<the quick brown fox jumps over the lazy dog>, <supercalifragilisticexpialidocious>), 18;
is word-stickers(<the five boxing wizards jump quickly>,        <supercalifragilisticexpialidocious>), 12;
is word-stickers(<pack my box with five dozen liquor jugs>,     <supercalifragilisticexpialidocious>), 15;

sub word-stickers($s, $w)
{
    return 0 if $w.comb (-) $s.comb(/<lower>/);

    my @stickers = $s>>.comb>>.Bag;
    my $word = $w.comb.BagHash;

    .elems given gather while $word
    {
        my $i = @stickers.map({ ($_ (&) $word).total }).maxpairs.head.key
                                                        andthen .take;
        $word.remove(@stickers[$i].kxxv)
    }
}
