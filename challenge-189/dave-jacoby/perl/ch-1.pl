#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

my @input = (
    [ [qw{ e m u g }],  'b' ],
    [ [qw{ c d e f  }], 'a' ],
    [ [qw{ j a r }],    'o' ],
    [ [qw{ d c e f }],  'a' ],
    [ [qw{ t g a l  }], 'v' ],
);

for my $input (@input) {
    my @list   = $input->[0]->@*;
    my $list   = join ', ', @list;
    my $target = $input->[1];
    my $output = greater_character( $target, @list );

    say <<"END";
        Input:  \@array = ($list) , \$target = $target
        Output: $output
END
}

sub greater_character ( $target, @array ) {
    my @shorter =
        map  { $_->[1] }
        grep { $_->[1] ne $target }
        map {
        [ sort { $a cmp $b } $_, $target ]
        } sort @array;
    return $shorter[0] // $target;
}
