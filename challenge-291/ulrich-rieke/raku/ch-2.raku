use v6 ;

sub different_hands( ) {
   my $dividend = [*] (48..52) ;
   my $divisor = [*] (1..5) ;
   return $dividend div $divisor ;
}

sub faculty( $number is copy ) {
   return [*] (1..$number) ;
}

sub combinations( $total is copy , $selected is copy ) {
   my $dividend = faculty( $total ) ;
   my $divisor = faculty( $total - $selected ) * faculty( $selected ) ;
   return $dividend div $divisor ;
}
my $select_hands = different_hands( ) ;
my $royal_flush = 4 ; #one sequence for every suite
my $straight_runs = 8 ; #there are 8 possible different downruns of consecutive
#five cards from ace to 2
my $straight_flush = $straight_runs * 4 ; #downruns times suit number
my $four_of_a_kind = 13 * 12 * 4 ; #13 possible four run , times 12 for the 
#remaining kinds , times 4 for every suit
my $full_house = combinations( 4 , 3 ) * 13 * combinations( 4 , 2 ) * 12 ;
#there are 4 over 3 possible ways to select 3 suits from four, 1 for all 13 
#kinds, times 4 over 2 for pairing possibilities , times 12 for the rest of
#kinds available
my $flush = combinations(13 , 5 ) * 4 ; #13 over 5 possibilities to select 5 
#kinds from 13 , times 4 for every suit
my $straight = 4 * 8 * 4 * 4 * 4 * 4 ; #8 possible ways to start a straight ,
#times 4 for every suit , then 4 choices for every subsequent card
my $three_of_a_kind = combinations( 4 , 3 ) * 13 * 4 * 12 * 4 * 11 ;
#four over three possibilities to select 3 suits from four , times number of
#kinds , for the remaining 2 positions : number of kinds left times number of
#suits
my $two_pair = combinations( 4 , 2 ) * 13 * combinations( 4 , 2 ) * 12 * 4 
 * 11 ; #number of possibilities to select 2 from four , times number of 
#kinds, same again times number of remaining kinds , times number of kinds 
#remaining times number of suits
my $pair = combinations( 4 , 2 ) * 13 *  12 * 11 * 10 ;
#number of combinations to pick 4 suits from four , times number of kinds , 
#for every positions afterwards : number of kinds remaining 
my $highcards = $select_hands - $royal_flush - $straight_flush -
$full_house - $flush - $straight - $three_of_a_kind - $two_pair - $pair ;
say "different hands : $select_hands, royal flush : $royal_flush" ;
say "straight flush : $straight_flush , full house : $full_house" ;
say "flush : $flush , straight : $straight" ;
say "three of a kind : $three_of_a_kind , two pair : $two_pair" ;
say "pair : $pair, highcards : $highcards" ;
