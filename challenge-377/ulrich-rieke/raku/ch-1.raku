use v6 ;

say "Enter a string!" ;
my $word = $*IN.get ;
my $len = $word.chars ;
my %forward_pairs ;
for (0..$len - 2) -> $i {
   %forward_pairs{$word.substr( $i , 2 )}++ ;
}
my $backword = $word.comb.reverse.join ;
my %backward_pairs ;
for (0..$len - 2) -> $i {
   %backward_pairs{ $backword.substr( $i , 2 )}++ ;
}
say %forward_pairs.keys.grep( { %backward_pairs{$_}:exists } ).elems > 0 ;
