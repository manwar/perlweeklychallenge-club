//given the formal ties and a letter sequence, find the new ties
fn find_ties( results : &str , ties : &Vec<(u8 , u8)> ) -> Vec<u8> {
    let mut seedings : Vec<u8> = Vec::new( ) ;
    let result_pairs : Vec<(char , &(u8 , u8))> = results.chars( ).
        zip( ties.iter( ) ).collect( ) ;
    result_pairs.iter().map( |(letter , pair)| {
            if *letter == 'H' {
               pair.0
            }
            else {
               pair.1
            }
            }).for_each( |n| seedings.push( n ) ) ;
    seedings.sort( ) ;
    seedings
}

fn final_result( result_string : &str ) -> String {
    let passed : String = result_string.into( ) ;
    let first_part : &str = &passed[0..3] ;
    let first_round_seedings : Vec<u8> = find_ties( first_part , 
            &vec![(2 , 7) , ( 3, 6) , (4 , 5)]) ;
    let second_part : &str = &passed[3..5];
    let mut second_seedings : Vec<u8> = find_ties( second_part , &vec![(
                1 , first_round_seedings[2] ) , (first_round_seedings[0] , 
                    first_round_seedings[1])] ) ;
    second_seedings.sort( ) ;
    let result : String ;
    if result_string.chars( ).nth( 5).unwrap( ) == 'H' {
        result = format!("Team {} defeated Team {}" , second_seedings[0] , 
                second_seedings[1]) ;
    }
    else {
        result = format!("Team {} defeated Team {}" , second_seedings[1] , 
                second_seedings[0] ) ;
    }
    result
}


fn main() {
    println!("{:?}" , final_result("HAHAHH"));
    println!("{:?}" , final_result( "HHHHHH")) ;
    println!("{:?}" , final_result( "HHHAHA" )) ;
    println!("{:?}" , final_result( "HAHAAH" ) ) ;
    println!("{:?}" , final_result( "HAAHAA" ) ) ;
}
