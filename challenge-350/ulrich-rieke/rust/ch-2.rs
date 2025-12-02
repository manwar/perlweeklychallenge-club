use std::collections::HashSet ;

fn are_shuffled( first_num : u32 , second_num : u32 ) -> bool {
    let mut first_str : String = first_num.to_string( ) ;
    let mut second_str : String = second_num.to_string( ) ;
    let len : usize = first_str.len( ) ;
    if first_str.len( ) == second_str.len( ) {
        let mut first_letters : HashSet<char> = HashSet::new( ) ;
        let mut second_letters : HashSet<char> = HashSet::new( ) ;
        while let Some( c ) = first_str.pop( ) {
            first_letters.insert( c ) ;
        }
        while let Some( c ) = second_str.pop( ) {
            second_letters.insert( c ) ;
        }
        first_letters == second_letters && first_letters.len( ) == len 
    }
    else {
        false 
    }
}

fn find_witnessed_pairs( from : u32 , to : u32 , count : usize ) -> usize {
    let mut pairs : Vec<u32> = Vec::new( ) ;
    for n in from..=to {
        let mut pairnum : usize = 0 ;
        'inner :for mult in 2..10 {
            if are_shuffled( n , mult * n ) {
                pairnum += 1 ;
                if pairnum == count {
                    pairs.push( n ) ;
                    break 'inner ;
                }
            }
        }
    }
    pairs.len( )
}

fn main() {
    println!("{}" , find_witnessed_pairs( 1 , 1000 , 0 ));
    println!("{}" , find_witnessed_pairs( 1500 , 2500 , 1 ) ) ;
    println!("{}" , find_witnessed_pairs( 1000000 , 1500000 , 5 ) ) ;
    println!("{}" , find_witnessed_pairs( 13427000 , 14100000 , 2 )) ;
    println!("{}" , find_witnessed_pairs( 1030 , 1130 , 1 )) ;
}
