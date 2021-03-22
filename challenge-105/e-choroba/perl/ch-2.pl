#!/usr/bin/perl
use warnings;
use strict;

sub name_game {
    my ($name) = @_;

    my %name;
    if ($name =~ /^[^AEIOU]/) {
        %name = map {
            $_ => ($_ x (0 != index $name, uc)) . substr $name, 1
        } qw( b f m );

    } else {
        $name{$_} = $_ . lc $name for qw( b f m );
    }

    return sprintf join("\n", '%s, %s, bo-%s,',
                             'Bonana-fanna fo-%s',
                             'Fee fi mo-%s',
                             '%s!'),
                   ($name) x 2, @name{qw{ b f m }}, $name
}

use Test::More tests => 4;

is name_game('Katie'),
    "Katie, Katie, bo-batie,\nBonana-fanna fo-fatie\nFee fi mo-matie\nKatie!",
    'Katie';

is name_game('Billy'),
    "Billy, Billy, bo-illy,\nBonana-fanna fo-filly\nFee fi mo-milly\nBilly!",
    'Billy';

is name_game('Fred'),
    "Fred, Fred, bo-bred,\nBonana-fanna fo-red\nFee fi mo-mred\nFred!",
    'Fred';

is name_game('Marsha'),
    "Marsha, Marsha, bo-barsha,\nBonana-fanna fo-farsha\nFee fi mo-arsha\nMarsha!",
    'Marsha';

is name_game('Anna'),
    "Anna, Anna, bo-banna,\nBonana-fanna fo-fanna\nFee fi mo-manna\nAnna!",
    'Anna';
