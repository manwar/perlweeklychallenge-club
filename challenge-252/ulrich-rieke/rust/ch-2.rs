use std::io ;

fn main() {
    println!("Enter a positive integer!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let num : u32 = entered_line.trim( ).parse::<u32>( ).unwrap( ) ;
    let mut solution : Vec<i32> = Vec::new( ) ;
    let limit : u32 = num.div_euclid( 2 ) ;
    let neg_limit : i32 = (limit as i32) * ( -1 ) ;
    if num % 2 == 1 {
       let pos_limit : i32 = limit as i32 ;
       for i in neg_limit..=pos_limit {
	  solution.push( i ) ;
       }
    }
    else {
       let mut current : i32 = neg_limit ;
       for _ in 0..num - 1 {
	  solution.push( current ) ;
	  current += 1 ;
       }
       let sum : i32 = solution.iter( ).sum::<i32>( ) ;
       solution.push( 0 - sum ) ;
    }
    println!("{:?}" , solution ) ;
}
