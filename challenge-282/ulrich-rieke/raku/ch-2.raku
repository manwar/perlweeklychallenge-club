use v6 ;

say "Enter an alphabetic string!" ;
my $word = $*IN.get ;
#we create pairs of neighbouring letters and convert every member of these
#pairs into lowercase letters. After that , we count the pairs with 
#unequal letters
say $word.comb.rotor( 2 => -1 ).map( {$_.map( {.lc} ) } ).grep( {$_[0] ne
      $_[1] } ).elems ;
