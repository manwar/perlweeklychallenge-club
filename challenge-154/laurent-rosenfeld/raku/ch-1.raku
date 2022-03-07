my $given_perm = set(qw/
    PELR PREL PERL PRLE PLER PLRE EPRL EPLR ERPL
    ERLP ELPR ELRP RPEL RPLE REPL RELP RLPE RLEP
    LPER LPRE LEPR LRPE LREP /);
for "PERL".comb.permutations>>.join("") -> $perm {
    say "$perm is missing" if $perm ∉ $given_perm;
}
