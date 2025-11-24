use v6 ;

say "Enter a word!" ;
my $word = $*IN.get ;
my @frequencies ;
my @allLetters = $word.comb ;
my $lastChar = @allLetters[0] ;
my $count = 1 ;
for $word.substr( 1 ).comb -> $c {
    if ( $c eq $lastChar ) {
        $count++ ;
    }
    else {
        my @element = ($lastChar , $count ) ;
        @frequencies.push( @element ) ;
        $count = 1 ;
        $lastChar = $c ;
    }
}
@frequencies.push( ($lastChar , $count ) ) ;
my @sorted = @frequencies.sort( { $^b[1] <=> $^a[1] } ) ;
say @sorted[0][1] ;
