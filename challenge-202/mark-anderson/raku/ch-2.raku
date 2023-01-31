#!/usr/bin/env raku

say widest-valley(< 1 2 2 5 4 1 0 2 3 2 1 3 4 3 1 32 11 11 8 >);
say widest-valley(< 1 2 2 5 4 1 0 0 0 0 0 2 3 4 5 32 11 11 8 >);
say widest-valley(< 1 1 1 1 1 2 5 >);
say widest-valley(< 32 11 11 8 >);
say widest-valley(< 11 11 11 8 4 2 4 8 11 11 11 >);
say widest-valley((10..50).roll(1000));

sub widest-valley(*@a)
{
    my @decreasing;
    my @increasing;

    until @a <= 1
    {
        my $k = ([\>=] @a).first({ .not }, :k) // @a.elems;
        @decreasing.push: @a.splice(0, $k, @a[$k-1]);
        
        $k = ([\<=] @a).first({ .not }, :k) || @a.elems;
        @increasing.push: @a.splice(0, $k, @a[$k-1]);
    }

    @a = @decreasing Z @increasing;

    my $a := gather for @a
    {
        pop  .[0];
        take .comb(/\d+/)
    }

    $a[$_] given $a.cache>>.elems.maxpairs.first.key
}
