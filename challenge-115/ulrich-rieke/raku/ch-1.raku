use v6 ;

#we form two hashes of start and end letters. If these 2 are equal ( same
#keys , same occurrences of keys) , a ring can be formed, otherwise not

say "Enter an array of strings, separated by blanks!" ;
my $line = $*IN.get ;
my @strings = $line.split( /\s+/ ) ;
my %startletters ;
my %endletters ;
for @strings -> $string {
  %startletters{ $string.substr( 0 , 1 )}++ ;
  %endletters{ $string.substr( $string.chars - 1 , 1 )}++ ;
}
for %startletters.keys -> $key {
  if ( not (%endletters{ $key }:exists) or %startletters{ $key } ne
    %endletters{ $key }) {
      say 0 ;
      exit( 0 ) ;
  }
}
say 1 ;
