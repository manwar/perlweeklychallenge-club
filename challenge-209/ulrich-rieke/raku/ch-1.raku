use v6 ;

say "Enter a byte string, consisting of 1 and 0 only!" ;
my $line = $*IN.get ;
my $valids = ("0" , "10" , "11" ).Set ;
my @seqs = $line.comb.rotor( 2 , :partial ).Array ;
my @strings = @seqs.map( {$_.join('').Str} ) ;
if (@strings.grep( { $_ (elem) $valids } ).elems == @strings.elems) {
  my $last_element = @strings[*-1] ;
  if ( $last_element eq "0" || $last_element eq "00" ) {
      say 1 ;
  }
  else {
      say 0 ;
  }
}
else {
  say 0 ;
}
