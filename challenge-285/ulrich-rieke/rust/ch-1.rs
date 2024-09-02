use std::io ;

fn main() {
    println!("Enter some routes!");
    println!("Enter start and destination by blank, routes by ','!" ) ;
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let routes : Vec<&str> = entered_line.split( ",").collect( ) ;
    let pairs : Vec<Vec<&str>> = routes.iter( ).map( | s |
	  s.split_whitespace( ).collect( ) ).collect( ) ;
    let mut solution : Vec<&str> = Vec::new( ) ;
    for p in &pairs {
       let destination = p[1] ;
       if pairs.iter( ).filter( | &a_pair | a_pair[0] == destination ).
	     count( ) == 0 {
		solution.push( destination ) ;
	     }
    }
    println!("{:?}" , solution ) ;
}
