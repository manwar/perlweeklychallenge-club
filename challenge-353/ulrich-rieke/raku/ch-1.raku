use v6 ;

say "Enter some strings , enter <return> to end!" ;
my @sentences ;
my $line = $*IN.get ;
while ( $line ) {
    @sentences.push( $line ) ;
    $line = $*IN.get ;
}
my @lengths ;
for @sentences -> $string {
    my @singlewords = $string.words ;
    @lengths.push( @singlewords.elems ) ;
}
say @lengths.max ;
