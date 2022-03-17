#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtabs
use v6.d;
use lib $?FILE.IO.parent(2).add("lib");

# Missing Permutation

my Set $given = set
'PELR, PREL, PERL, PRLE, PLER, PLRE, EPRL, EPLR, ERPL,
ERLP, ELPR, ELRP, RPEL, RPLE, REPL, RELP, RLPE, RLEP,
LPER, LPRE, LEPR, LRPE, LREP'.split: / ',' \s* / ;

my $base = 'PERL';

my $muts = set $base.split('', :skip-empty ).permutations.map: {.join};

say "Missing:  ", ($muts∖$given).Str;
