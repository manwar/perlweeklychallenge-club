#!/usr/bin/perl6

multi sub MAIN {
    my %rings = (
        'Blue'         => 8,
        'Yellow'       => 7,
        'Green'        => 5,
        'Red'          => 9,
    );

    my @ringSegments = [
        << Red Red-Green >>,
        << Green Red-Green Green-Black >>,
        << Black Green-Black Black-Yellow >>,
        << Yellow Black-Yellow Yellow-Blue >>,
        << Blue Yellow-Blue >>,
    ];

    my @unknowns = << Black Red-Green Green-Black Black-Yellow Yellow-Blue >>;
    my @numbers = (1, 2, 3, 4, 6);


    for @numbers.permutations -> @permutation {
        my %try = %rings;
        my $i = 0;
        @unknowns.map({ %try{$_} = @permutation[$i++]; });

        my %ringValues;
        @ringSegments.map({%ringValues{$_[0]} = 0; });

        for @ringSegments -> @ring {
            @ring.map({ %ringValues{@ring[0]} += %try{$_} });
        }

        if (%ringValues.values.all == 11) {
            @unknowns.map({ say "$_ = %try{$_}"; });
            last;
        }
    }
}
