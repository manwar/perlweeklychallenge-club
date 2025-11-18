use v6 ;

say "Enter a source time!" ;
my $source = $*IN.get ;
say "Enter a target time!" ;
my $target = $*IN.get ;
my @ops = (1 , 5 , 15 , 60 ) ;
my ( $sourcehours , $sourceminutes , $targethours , $targetminutes ) ;
if ( $source ~~ /(\d ** 2) ':' (\d ** 2 )/) {
    ($sourcehours , $sourceminutes ) = ( +$0 , +$1 ) ;
}
if ( $target ~~ /(\d ** 2) ':' (\d ** 2)/ ) {
    ($targethours , $targetminutes ) = ( +$0 , +$1 ) ;
}
if ( $targethours < $sourcehours ) {
    $targethours += 24 ;
}
my $diffminutes = $targethours * 60 + $targetminutes - ( $sourcehours * 60
        + $sourceminutes ) ;
my @operations ;
while ( $diffminutes != 0 ) {
    my @smaller =  @ops.grep( { $_ <= $diffminutes } ) ;
    my $divisor = @smaller.max ;
    @operations.push( $diffminutes div $divisor ) ;
    $diffminutes -= $divisor * @operations[*-1] ;
}
say [+] @operations ;


