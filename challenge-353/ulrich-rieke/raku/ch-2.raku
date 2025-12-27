use v6 ;

say "Enter some codes separated by blanks!" ;
my $line = $*IN.get ;
my @codes = $line.words ;
say "Enter categories separated by blanks!" ;
$line = $*IN.get ;
my @names = $line.words ;
say "Enter as many status codes separated by blanks!" ;
$line = $*IN.get ;
my @status = $line.words ;
my $categories = set <electronics grocery pharmacy restaurant> ;
my $len = @codes.elems ;
my @result ;
for (0..$len - 1) -> $i {
    if ( @codes[$i] ~~ /^\w+$/ ) && ( @names[$i] (elem) $categories ) &&
        ( @status[$i] eq "true" ) {
            @result.push( "true" ) ;
        }
    else {
        @result.push( "false") ;
    }
}
say '(' ~ @result.join( ',' ) ~ ')' ;
