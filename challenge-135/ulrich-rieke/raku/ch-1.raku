use v6 ;

sub MAIN( Str $input is copy ) {
  say $input ;
  while ( $input !~~ /^<[+-]>*\d+$/ ) {
      say "Please enter digits only!" ;
      $input = $*IN.get ;
  }
  my $len = $input.chars ;
  if ( $len == 4 && $input.substr( 0 , 1 ) ~~ /<[+-]>/ ) {
      say $input.substr( 1 ) ;
  }
  else {
      given $len {
    when $_ %% 2 { say "even number of digits" }
    when ($_ < 3 and not $_ %% 2 ) { say "too short" }
    when (not $_ %% 2 and $_ > 3 ) { say $input.substr( ( $len - 3 )
          div 2 , 3 ) }
      }
  }
}
