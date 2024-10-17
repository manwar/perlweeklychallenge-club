fn compute_different_hands( ) -> u64 {
   //it's (52! / ( 52 - 5 )! * 5! ) 
   //that is 48 * 49 * 50 * 51 * 52 / (1 * 2 * 3 * 4 * 5 ) 
   let dividend : u64 = (48..=52).product( ) ;
   let divisor : u64 = (1..=5).product( ) ;
   dividend / divisor 
}

//how many straight runs are there ?
fn find_straight_runs( ) -> u64 {
   let mut values : Vec<u64> = Vec::new( ) ;
   let mut value : u64 = 13 ;
   while value != 2 {
      values.push( value ) ;
      value -= 1 ;
   }
   let val_slice = &values[..] ;
   let mut runs : u64 = 1 ;
   let mut iter = val_slice.windows( 5 ) ;
   while let Some( _combi ) = iter.next( ) {
      runs += 1 ;
   }
   runs 
}

fn combinations( total : u64 , selected : u64 ) -> u64 {
   let dividend : u64 = faculty( total ) ;
   let divisor : u64 = faculty( total - selected ) * faculty( selected ) ;
   dividend / divisor 
}

fn faculty( number : u64 ) -> u64 {
   (1..=number).product( ) 
}

fn main() {
    //this is an exercise in probabilistic reasoning!
    let royal_flush : u64 = 4 ; // one ten-to-ace straight for every suit
    let straight_runs : u64 = find_straight_runs( ) ;
    let straight_flush : u64 = straight_runs * 4 ; 
    let four_of_a_kind : u64 = 13 * 12 * 4 ; //one for every value , 
    // times one of the other 12 cards not in the kind, times every suit
    let full_house : u64 = combinations( 4 , 3 ) * 13 * combinations( 4 , 2 ) 
       * 12 ;
    //full_house : there are "four over three" combinations for three out
    //of four , times 13 , times "four over two" combinations of 2 suits
    //out of four
    //times 12 ( the number of suits that do not form the triplet )
    let flush : u64 = combinations( 13 , 5 ) * 4 ;
    //flush : all combinations of 5 cards out of 13 , times 4 for every 
    //suit 
    let straight : u64 = 4 * 8 * 4 * 4 * 4 * 4 ; 
    //straight : 8 possible first positions for a straight , times 4 for every 
    //suit , then 4 following cards for every position and suit
    let three_of_a_kind : u64 = combinations( 4 , 3 ) * 13 * 4 * 12 * 4 * 11 ; 
    //three_of_a_kind : 4 over 3 different ways of selecting 3 same values
    //from different suits , times 13 for every kind , times 12 for the
    //remaining 12 kinds times 4 for the suits , times 4 for the suits and 
    //11 for the remaining kinds
    let two_pair : u64 = combinations( 4 , 2 ) * 13 * combinations( 4 , 2 ) *
       12 * 4 * 11 ;
    //two_pair: for the first pair : four over two for the combinations
    //times 13 for the kinds , for the second pair : four over two for the
    //combinations times 12 for the remaining kinds , times 10 for the 
    //remaining kinds times 4 for all suits
    let pair : u64 = combinations( 4 , 2 ) * 13 *  12 *  11  * 10 ;
    //pair : four over two for the combinations times 13 for the kinds , 
    // times  12 for the third position , times 11 for the fourth ,
    // times 10 for the fifth ( we want to avoid another pair or triplet)
    let different_hands : u64 = compute_different_hands( ) ;
    let high_card : u64 = different_hands - royal_flush - straight_flush -
       full_house - flush - straight - three_of_a_kind - two_pair - pair ;
    //high_card : the rest
    println!("all different hands:{}" , different_hands ) ;
    println!("royal flush: {}" , royal_flush ) ;
    println!("straight flush: {}" , straight_flush ) ;
    println!( "four of a kind: {}" , four_of_a_kind ) ;
    println!( "full house : {}" , full_house ) ;
    println!("flush : {}" , flush ) ;
    println!("straight : {}" , straight ) ;
    println!( "three-of-a-kind : {}" , three_of_a_kind ) ;
    println!( "two-pair : {}" , two_pair ) ;
    println!( "pair : {}" , pair ) ;
    println!( "high card : {}" , high_card ) ;
    //high card : the rest!
}
