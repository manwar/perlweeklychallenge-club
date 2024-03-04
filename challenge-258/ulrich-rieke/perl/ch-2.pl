use v5.36.0 ;

say "Enter some integers, separated by spaces!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
say "Enter another integer!" ;
my $k = <STDIN> ;
chomp $k ;
my $sum = 0 ;
my $len = scalar( @numbers ) ;
for my $i (0..$len - 1 ) {
   my $binary = sprintf "%b" , $i ;
   my @suitables = grep { $_ eq '1' } split( // , $binary ) ;
   if ( scalar( @suitables ) == $k ) {
      $sum += $numbers[ $i ] ;
   }
}
say $sum ;
