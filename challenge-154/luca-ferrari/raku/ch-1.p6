#!raku

sub MAIN( Str $needle = 'PERL',
              @input =  qw/ PELR PREL PERL PRLE PLER PLRE EPRL EPLR ERPL
                         ERLP ELPR ELRP RPEL RPLE REPL RELP RLPE RLEP
                         LPER LPRE LEPR LRPE LREP /  ) {

    $needle.comb.permutations.map( { $_.join unless @input.grep( $_.join ) } ).join( "\n" ).say;
}
