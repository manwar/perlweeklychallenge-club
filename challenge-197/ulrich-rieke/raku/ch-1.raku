use v6 ;

say "Enter some integers , separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.split( /\s/ ).map( {.Int} ) ;
my @nonzeroes = @numbers.grep( { $_ != 0 } ) ;
my @zeroes = @numbers.grep( { $_ == 0 } ) ;
my @ordered = @nonzeroes.push( |@zeroes ) ;
say '(' ~ @ordered.join( ',' ) ~ ')' ;
