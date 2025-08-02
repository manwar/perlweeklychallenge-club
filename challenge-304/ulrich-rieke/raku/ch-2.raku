use v6 ;

say "Enter some integers separated by blanks!" ;
my $line = $*IN.get ;
my @numbers = $line.words.map( {.Int} ) ;
say "Enter a number shorter than or equal to to length of the array above!" ;
my $n = $*IN.get ;
my $num = +$n ;
my $maxi = @numbers.min ;#initialze with smallest element in @numbers
my $len = @numbers.elems ;
for (0..$len - $num) -> $start {
   my $subsum = [+] @numbers[$start..$start + $num - 1] ;
   my $avg = $subsum / $num ;
   if ( $avg > $maxi ) {
      $maxi = $avg ;
   }
}
$maxi.say ;
