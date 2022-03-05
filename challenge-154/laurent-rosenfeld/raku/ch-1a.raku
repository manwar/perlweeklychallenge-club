my $given_perm = set(qw/
    PELR PREL PERL EPRL EPLR ERPL
    ERLP ELPR ELRP RPEL RLPE RLEP
    LPER LPRE LEPR LRPE LREP /);
my $perms = set($given_perm.keys[0].comb.permutations>>.join(""));
say "Missing: ", ~($perms (-) $given_perm);
