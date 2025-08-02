use v5.36.0 ;

say "Enter a word!" ;
my $firstWord = <STDIN> ;
chomp $firstWord ;
say "Enter a second word with the same characters as above + 1!" ;
my $secondWord = <STDIN> ;
chomp $secondWord ;
my %firstFreq ;
my %secondFreq ;
for my $letter ( split ( // , $firstWord ) ) {
   $firstFreq{ $letter }++ ;
}
for my $letter( split( // , $secondWord ) ) {
   $secondFreq{ $letter }++ ;
}
my @selected = grep { ( not exists( $firstFreq{ $_ } ) ) || $secondFreq{ $_ } != 
   $firstFreq{ $_ } } keys %secondFreq ;
say $selected[ 0 ] ;   
