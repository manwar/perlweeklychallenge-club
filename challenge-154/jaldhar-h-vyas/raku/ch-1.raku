#!/usr/bin/raku

sub MAIN() {
    my @partial = < PELR PREL PERL PRLE PLER PLRE EPRL EPLR ERPL ERLP ELPR ELRP
    RPEL RPLE REPL RELP RLPE RLEP LPER LPRE LEPR LRPE LREP >;

    my @full = "PERL".comb.permutations().map({ .join; });

    say (@full ∖ @partial).keys.join(q{ });
}