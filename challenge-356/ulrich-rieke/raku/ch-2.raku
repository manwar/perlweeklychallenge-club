use v6 ;

#find a seeding order depending on the result ( represented by a string )
#and the ties
sub find_ties( $result , @ties ) {
    my @seedings ;
    my @result_pairs = $result.comb Z, @ties ;
    for @result_pairs -> $pair {
        if ( $pair[0] eq "H" ) {
            @seedings.push( $pair[1][0] ) ;
        }
        else {
            @seedings.push( $pair[1][1] ) ;
        }
    }
    @seedings .= sort( { $^a <=> $^b } ) ;
    return @seedings ;
}

sub find_result( $resultstring ) {
    my @first_round_seedings = find_ties( $resultstring.substr( 0 , 3 ) , 
            ((2 , 7) , (3 , 6 ) , (4 , 5 ))) ;
    my @second_round_seedings = find_ties( $resultstring.substr( 3, 2 ) , 
            ((1 , @first_round_seedings[2]) , (@first_round_seedings[0] , 
                @first_round_seedings[1]))) ;
    @second_round_seedings .= sort( { $^a <=> $^b } ) ;
    my $result ;
    if ( $resultstring.substr( 5 , 1 ) eq "H" ) {
        $result = "Team " ~ ~@second_round_seedings[0] ~ " defeated Team " ~
            ~@second_round_seedings[1] ;
    }
    else {
        $result = "Team " ~ ~@second_round_seedings[1] ~ " defeated Team " ~
            ~@second_round_seedings[0] ;
    }
    return $result ;
}

("HAHAHH" , "HHHHHH" , "HHHAHA"  , "HAHAAH" , "HAAHAA").map( { say 
    find_result( $_ ) } ) ;                                                         

