#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub alien_dictionary($alien, @words) {
    my $replace = join "", @$alien;
    return [map $_->[0],
            sort { $a->[1] cmp $b->[1] }
            map [$_, eval "tr/$replace/a-z/r"],
            @words]
}

use Test2::V0;
plan 2;

is alien_dictionary([qw[ h l a b y d e f g i r k m n o p q j s t u v w x c z ]],
                    qw( perl python raku )),
    [qw[ raku python perl ]],
    'Example 1';

is alien_dictionary([qw[ c o r l d a b t e f g h i j k m n p q s w u v x y z ]],
                    qw( the weekly challenge )),
    [qw[ challenge the weekly ]],
    'Example 2';
