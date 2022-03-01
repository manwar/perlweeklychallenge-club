#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(missingpermutations(["PELR", "PREL", "PERL", "PRLE", "PLER",
                               "PLRE", "EPRL", "EPLR", "ERPL", "ERLP",
                               "ELPR", "ELRP", "RPEL", "RPLE", "REPL",
                               "RELP", "RLPE", "RLEP", "LPER", "LPRE",
                               "LEPR", "LRPE", "LREP"]),
          ["LERP"],'example 1');

sub missingpermutations(@list) {
    my @p=@list[0].comb;
    my $perms=SetHash.new;
    for @p.permutations -> $i {
        $perms{$i.join('')}=True;
    }
    for @list -> $i {
        $perms{$i}:delete;
    }
    return [$perms.keys];
}
