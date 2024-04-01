use v5.36.0 ;

say "Enter some integers separated by spaces!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
say scalar( grep { length( $_ ) % 2 == 0 } @numbers ) ;
