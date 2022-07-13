use v6 ;

my @sylvesters = ( 2 , 3 ) ;
while ( @sylvesters.elems != 10 ) {
  @sylvesters.push( ([*] @sylvesters) + 1 ) ;
}
@sylvesters.map( { $_.say } ) ;
