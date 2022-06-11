#!/usr/bin/env raku

use Test;

my $list := <PELR PREL PERL PRLE PLER PLRE EPRL EPLR ERPL
             ERLP ELPR ELRP RPEL RPLE REPL RELP RLPE RLEP>;

is-deeply missing-permutations($list), set <LERP LPER LPRE LEPR LRPE LREP>;

sub missing-permutations($list)
{
    $list.head.comb.permutations>>.join (-) $list;
}
