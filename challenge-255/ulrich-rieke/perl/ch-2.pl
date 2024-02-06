use v5.36.0 ;
#this includes all of use strict, use warnings, use feature 'say' !!!

say "Enter a paragraph of words, <return> to end!" ;
my @paragraph ;
my $line = <STDIN> ;
chomp $line ;
while ( $line ) {
   push @paragraph, $line ;
   $line = <STDIN> ;
   chomp $line ;
}
say "Enter a banned word!" ;
my $banned = <STDIN> ;
chomp $banned ;
my %frequencies ;
for my $sentence ( @paragraph ) {
   my @words = split( /\s+/ , $sentence ) ;
   for my $word ( @words ) {
      $word =~ s/(.+)\W$/$1/ ;
      $frequencies{ $word }++ ;
   }
}
my @sorted = sort { $frequencies{ $b } <=> $frequencies{ $a } } keys %frequencies ;
if ( $sorted[0] ne $banned ) {
   say $sorted[0] ;
}
else {
   say $sorted[1] ;
}
