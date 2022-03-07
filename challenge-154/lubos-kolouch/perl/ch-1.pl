#!/usr/bin/env perl

use strict;
use warnings;

use Algorithm::Permute;

sub find_missing {
    my $what = shift;

    my $all_perms = Algorithm::Permute->new( [ split //, 'PERL' ] );

    my @output;

    while ( my @perm = $all_perms->next ) {
        my $look_str = join '', @perm;
        push @output, $look_str unless grep { /$look_str/ } @$what;
    }

    return \@output;
}

use Test::More;

is_deeply(
    find_missing(
        [
            "PELR", "PREL", "PERL", "PRLE", "PLER", "PLRE", "EPRL", "EPLR", "ERPL", "ERLP", "ELPR", "ELRP",
            "RPEL", "RPLE", "REPL", "RELP", "RLPE", "RLEP", "LPER", "LPRE", "LEPR", "LRPE", "LREP"
        ]
    ),
    ['LERP']
);

done_testing;
