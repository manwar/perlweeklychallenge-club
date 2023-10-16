use v6 ;

say "Enter some strings, separated by blanks!" ;
my $firstLine = $*IN.get ;
say "Enter some more strings, separated by blanks!" ;
my $secondLine = $*IN.get ;
$firstLine.subst-mutate( /\s+/ , '' , :g) ;
$secondLine.subst-mutate( /\s+/ , '' , :g) ;
say ( $firstLine eq $secondLine ) ;
