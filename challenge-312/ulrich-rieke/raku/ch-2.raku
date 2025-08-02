use v6 ;

say "Enter a line with G , R and B followed by box numbers!" ;
my $input = $*IN.get ;
my $len = $input.chars ;
my %boxes ;
my $pos = 0 ;
while ( $pos < $len - 1 ) {
   %boxes{$input.substr( $pos + 1 , 1 )}.push( $input.substr( $pos , 1 ) ) ;
   $pos += 2 ;
}
%boxes.values.map( {@_.Set} ) ;
say %boxes.keys.grep( {%boxes{$_}.elems == 3} ).elems ;
