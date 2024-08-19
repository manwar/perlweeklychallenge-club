use std::io ;
use std::collections::HashMap ;

fn main() {
    println!("Enter some integers several times , one only once!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let numbers : Vec<u32> = entered_line.split_whitespace( ).map( | s | 
	  s.parse::<u32>( ).unwrap( ) ).collect( ) ;
    let mut frequencies : HashMap<_,_> = HashMap::new( ) ;
    numbers.into_iter( ).for_each( | n | { 
	  frequencies.entry( n ).
	  and_modify( | e | *e += 1 ).or_insert( 1 ) ;
	  } ) ;
    for ( k , v ) in &frequencies {
       if *v == 1 {
	  println!("{}" , k ) ;
       }
    }
}
