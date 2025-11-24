use v6 ;

sub up( $point is copy ) {
    return ($point[0] , $point[1] + 1 ) ;
}

sub down( $point is copy ) {
    return ( $point[0] , $point[1] - 1 ) ;
}

sub left( $point is copy ) {
    return ( $point[0] - 1 , $point[1] ) ;
}

sub right( $point is copy ) {
    return ( $point[0] + 1 , $point[1] ) ;
}

say "Enter a sequence of letters U , D , R or L!" ;
my $motions = $*IN.get ;
my %movedirs = ( 'U' => &up , 'D' => &down , 'L' => &left , 'R' => &right ) ;
my $start = (0 , 0 ) ;
my $current = (0 , 0 ) ;
for $motions.comb -> $c {
    $current = %movedirs{$c}($current) ;
}
say ( $current[0] == $start[0] && $current[1] == $start[1] ) ;

