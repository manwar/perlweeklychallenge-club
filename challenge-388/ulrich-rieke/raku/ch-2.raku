use v6 ;

say "Enter a positive number!" ;
my $line = $*IN.get ;
my $number = $line.Int ;
if ( $number == 1 ) {
   say 0 ;
}
if ( $number == 2 ) {
   say 1 ;
}
if ( $number > 2 ) {
#create all permutations of the numbers 1 to $number and pair them up with
#1..$number. All pairs where both parts are different are acceptable. We enter
#them into a set to exclude duplicates
   my @original = (1..$number) ;
   my @permus = @original.permutations ;
   my @pairs ;
   for @permus -> @permu {
      my @paired = @original Z, @permu ;
      my @selected = @paired.grep( {$_[0] != $_[1]} ) ;
      if ( @selected.elems == @paired.elems ) {
         @pairs.push( @paired ) ;
      }
   }
   say @pairs.unique.elems ;
}
