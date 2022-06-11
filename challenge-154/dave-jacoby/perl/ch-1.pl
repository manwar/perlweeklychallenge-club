#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

use Algorithm::Permute;

my @sample = sort grep { /\w/ } split /\W+/, <<'END';
    PELR PREL PERL PRLE PLER PLRE EPRL EPLR ERPL
    ERLP ELPR ELRP RPEL RPLE REPL RELP RLPE RLEP
    LPER LPRE LEPR LRPE LREP 
END

my $p = Algorithm::Permute->new( [ split //, $sample[0] ] );
while ( my @str = $p->next ) {
    my $str = join '', @str;
    say $str unless grep { /$str/ } @sample;
}


