use std::io ;

fn main() {
    println!("Enter a source time!");
    let mut source : String = String::new( ) ;
    io::stdin( ).read_line( &mut source ).unwrap( ) ;
    println!("Enter a target time!") ;
    let mut target : String = String::new( ) ;
    io::stdin( ).read_line( &mut target ).unwrap( ) ;
    let dividers : Vec<u32> = vec![1 , 5 , 15 , 60] ;
    let starthours : u32 = source[0..2].parse::<u32>( ).unwrap( ) ;
    let startminutes : u32 = source[3..=4].parse::<u32>( ).unwrap( ) ;
    let mut targethours : u32 = target[0..2].parse::<u32>( ).unwrap( ) ;
    let targetminutes : u32 = target[3..=4].parse::<u32>( ).unwrap( ) ;
    if targethours < starthours {
        targethours += 24 ;
    }
    let mut diff_minutes : u32 = targethours * 60 + targetminutes - (
            starthours * 60 + startminutes ) ;
    let mut operations : Vec<u32> = Vec::new( ) ; 
    while diff_minutes != 0 {
        let divisor : u32 = *dividers.iter( ).filter( |&n| *n <=
                diff_minutes ).max( ).unwrap( ) ;
        operations.push( diff_minutes / divisor ) ;
        diff_minutes -= divisor * operations[operations.len( ) - 1] ;
    }
    println!("{}" , operations.into_iter( ).sum::<u32>( ) ) ;
}
