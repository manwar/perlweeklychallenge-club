
#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a line of integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s+/ , $line ) ;
my %nums ;
for my $num ( @numbers ) {
  $nums{ $num }++ ;
}
@numbers = sort { $a <=> $b } keys %nums ;
my @consecutives ;
my $len = scalar (@numbers) ;
my $chunksize = int( rand $len ) ;
my $currentPos = 0 ;
while ( ($currentPos + $chunksize - 1) < ($len - 1) ) {
  my @subarray = @numbers[$currentPos .. $currentPos + $chunksize - 1] ;
  push ( @consecutives , \@subarray ) ;
  $currentPos += $chunksize ;
}
if ( $currentPos < $len ) {
  my @subarray = @numbers[ $currentPos .. $len - 1 ] ;
  push @consecutives, \@subarray ;
}
print '(' ;
for my $ar ( @consecutives ) {
  print '[' ;
  for my $n ( @$ar ) {
      print " $n " ;
  }
  print ']' ;
}
say ')' ;
