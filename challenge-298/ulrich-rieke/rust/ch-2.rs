use std::io ;

fn main() {
    println!("Enter some integers , with the first , third and so on being unique!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s|
	  s.parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut pairs : Vec<(i32 , i32)> = Vec::new( ) ;
    let len = numbers.len( ) ;
    let mut current : usize = 0 ;
    while current < len - 1 {
       pairs.push( (numbers[current] , numbers[current + 1] ) ) ;
       current += 2 ;
    }
    let mut solution : Vec<i32> = Vec::new( ) ;
    for i in 0..pairs.len( ) {
       let possible_starts : Vec<i32> = pairs.iter( ).filter( |&p| 
	     p.0 >= pairs[i].1 ).map( |p| p.0 ).collect( ) ;
       if possible_starts.len( ) == 0 {
	  solution.push( -1 ) ;
       }
       else {
	  let mini : i32 = *possible_starts.iter( ).min( ).unwrap( ) ;
	  let pos = pairs.iter( ).position( |p| p.0 == mini ).unwrap( ) ;
	  solution.push( pos as i32 ) ;
       }
    }
    println!("{:?}" , solution ) ;
}
