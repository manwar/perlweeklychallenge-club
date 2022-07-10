# Rather than average two datapoints every time we calculate
# that the location of a median lies at a "halfway" point,
# it is more natural to calculate those locations separately,
# while allowing the "index" to stay fractional until the final step.
sub five_indexes ( @x ) {
    # https://en.wikipedia.org/wiki/Quartile#Method_2
    my \half   = @x.end       / 2;
    my \fourth = @x.end div 2 / 2;

    return 0, fourth, half, @x.end - fourth, @x.end;
}

# This solution is adapted from my private notes surrounding my solution: http://rosettacode.org/wiki/Fivenum#Raku
# Apparently I published my fifth iteration on RC, then improved it in a sixth version, but never published #6.
sub fivenum ( @nums where *.elems >= 1 ) {
    my @x = @nums.sort(+*);

    # Halfway indexes have adjacent floor and ceiling; the mean of those two elements is the desired number.
    # Integer indexes have the same floor and ceiling; the mean of identical elements is a harmless extra step.
    return @x.&five_indexes.map: { @x[.floor, .ceiling].sum / 2 };
}


# I was surprised by my own internal wrestling over the API of five_indexes().
# Notice that no data from @x is actually used, only the .elems or .end of the array is needed.
# As much as my efficiency wanted to only pass in a UInt, I kept envisioning how
# easy it would be to call five_indexes() incorrectly,
# and settled on passing the whole array to be less error-prone.
# This seems like a silly quibble over the API of a sub used only in a self-contained single-author script.


sub fivenum_-_working_alternate_-_almost_cool ( @nums where *.elems >= 1 ) {
    # Worked on a clever way to teach @a[] to
    # interpret half-way indexes as "average those two points".
    # Got it working for single access, 
    # but what I really wanted was array-slicing,
    # so the final return could be return @x[ @quartile_indexes ].
    # Needs more NQP than I know to make that work.

    # This teaches the array element lookup operator about a new special case: Rat index.
    my multi sub postcircumfix:<[ ]> ( \SELF, Rat:D \pos ) {
        return pos.denominator == 1 ??     SELF.AT-POS(pos)
            !! pos.denominator == 2 ?? ( ( SELF.AT-POS(pos.floor) +
                                           SELF.AT-POS(pos.ceiling) ) / 2 )
            !! die "NYI: Only handling half-way points right now";
    }

    my @x = @nums.sort(+*);

    my @indexes = five_indexes(@x);

    # return @x[@indexes]; # Ultimate goal, but too much COVID-19, not enough NQP.
    return @indexes.map: { @x[$_] };
}




multi sub MAIN ( *@nums ) {
    say fivenum(@nums);
}
multi sub MAIN ( ) {
    constant @tests =
        # Examples from http://rosettacode.org/wiki/Fivenum#Raku
        ( (15, 6, 42, 41, 7, 36, 49, 40, 39, 47, 43), (6, 25.5, 40, 42.5, 49) ),
        ( (36, 40, 7, 39, 41, 15), (7, 15, 37.5, 40, 41) ),
        (
            (
                0.14082834,  0.09748790,  1.73131507,  0.87636009, -1.95059594,
                0.73438555, -0.03035726,  1.46675970, -0.74621349, -0.72588772,
                0.63905160,  0.61501527, -0.98983780, -1.00447874, -0.62759469,
                0.66206163,  1.04312009, -0.10305385,  0.75775634,  0.32566578,
            ),
            (-1.95059594, -0.676741205, 0.23324706, 0.746070945, 1.73131507),
        ),
        # Solar system from https://en.wikipedia.org/wiki/Five-number_summary#Example
        ( (0, 0, 1, 2, 63, 61, 27, 13), (0, 0.5, 7.5, 44, 63) ),
        
        # https://en.wikipedia.org/wiki/Quartile#Discrete_distributions
        ( (6, 7, 15, 36, 39, 40, 41, 42, 43, 47, 49), (6, 25.5, 40, 42.5, 49) ),
        ( (7, 15, 36, 39, 40, 41), (7, 15, 37.5, 40, 41) ),
    ;

    use Test;
    plan 2+@tests;
    for @tests -> ( $input, $expected ) {
        my $got = fivenum($input);
        is-deeply $got».narrow, $expected».narrow, "fivenum($input[0], $input[1], ...)";
    }



    {
        # Made up two test datasets, based on powers of 2, with sizes ranging from 1 to 16 elements.
        # raku -e 'use Statistics; my @a = (2, 4, 8 ... *).head(16); say fivenum(@a.head($_)) for 1..16; say fivenum(@a.skip($_)) for ^16;'
        my @exp1 = 
            (2,  2,   2,    2,     2),
            (2,  2,   3,    4,     4),
            (2,  3,   4,    6,     8),
            (2,  3,   6,   12,    16),
            (2,  4,   8,   16,    32),
            (2,  4,  12,   32,    64),
            (2,  6,  16,   48,   128),
            (2,  6,  24,   96,   256),
            (2,  8,  32,  128,   512),
            (2,  8,  48,  256,  1024),
            (2, 12,  64,  384,  2048),
            (2, 12,  96,  768,  4096),
            (2, 16, 128, 1024,  8192),
            (2, 16, 192, 2048, 16384),
            (2, 24, 256, 3072, 32768),
            (2, 24, 384, 6144, 65536),
        ;
        my @exp2 = 
            (    2,    24,   384,  6144, 65536),
            (    4,    48,   512,  6144, 65536),
            (    8,    64,   768,  8192, 65536),
            (   16,   128,  1024,  8192, 65536),
            (   32,   192,  1536, 12288, 65536),
            (   64,   384,  2048, 12288, 65536),
            (  128,   512,  3072, 16384, 65536),
            (  256,  1024,  4096, 16384, 65536),
            (  512,  1536,  6144, 24576, 65536),
            ( 1024,  3072,  8192, 24576, 65536),
            ( 2048,  4096, 12288, 32768, 65536),
            ( 4096,  8192, 16384, 32768, 65536),
            ( 8192, 12288, 24576, 49152, 65536),
            (16384, 24576, 32768, 49152, 65536),
            (32768, 32768, 49152, 65536, 65536),
            (65536, 65536, 65536, 65536, 65536),
        ;
        my @a = (2, 4, 8 ... *).head(16);
        my @got1 = map { fivenum( @a.head($_) )».narrow.cache }, 1..16;
        my @got2 = map { fivenum( @a.skip($_) )».narrow.cache }, ^16;
        is-deeply @got1, @exp1, '16 heads of powers of two, compared against Statistics::fivenum';
        is-deeply @got2, @exp2, '16 skips of powers of two, compared against Statistics::fivenum';
    }
}
