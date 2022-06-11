my @in = <
    PELR PREL PERL PRLE PLER PLRE EPRL EPLR ERPL
    ERLP ELPR ELRP RPEL RPLE REPL RELP RLPE RLEP
    LPER LPRE LEPR LRPE LREP
>;

my @all = @in[0].comb.permutations».join;

say .key for @all (-) @in;
