use v6 ;

my $perlPermutations = ( "PELR", "PREL", "PERL", "PRLE", "PLER", "PLRE",
      "EPRL", "EPLR", "ERPL", "ERLP", "ELPR", "ELRP", "RPEL", "RPLE",
      "REPL", "RELP", "RLPE", "RLEP", "LPER", "LPRE", "LEPR",
      "LRPE", "LREP" ).Set ;

my $allPermutations = "PERL".comb.permutations.map( {.join} ).Set ;
say $allPermutations (-) $perlPermutations ;
