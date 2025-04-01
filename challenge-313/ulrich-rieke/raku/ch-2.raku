use v6 ;

say "Enter a string!" ;
my $word = $*IN.get ;
my @letters = $word.comb ;
my $reversed ;
my @alphabetic_letters ;
for @letters -> $c {
   if ( $c ~~ /<[a..zA..Z]>/ ) {
      @alphabetic_letters.push( $c ) ;
   }
}
@alphabetic_letters .= reverse ;
for @letters -> $c {
   if ( $c !~~ /<[a..zA..Z]>/ ) {
      $reversed ~= $c ;
   }
   else {
      my $letter = @alphabetic_letters.shift ;
      $reversed ~= $letter ;
   }
}
say $reversed ;

