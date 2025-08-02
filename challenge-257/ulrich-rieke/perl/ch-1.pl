use v5.36.0 ;

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
my @result ;
for my $num( @numbers ) {
   push @result , scalar( grep { $_ < $num } @numbers ) ;
}
say "(" . join( ',' , @result ) . ")" ;
