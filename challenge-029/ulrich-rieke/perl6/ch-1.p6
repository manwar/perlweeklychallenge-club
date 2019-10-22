use v6 ;

#works only if there are no spaces in the expansion bracket!
sub MAIN( **@ARGS ) {
  my $howoften = @ARGS.elems - 2 ;
  for (1..$howoften) -> $i {
      say "@ARGS[0] @ARGS[$i] @ARGS[*-1]" ;
  }
}
