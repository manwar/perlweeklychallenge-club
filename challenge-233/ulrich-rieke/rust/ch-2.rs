use std::io ;
use std::collections::HashSet ;

fn main() {
    println!("Enter some integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s | 
	  s.trim( ).parse::<i32>( ).unwrap( )).collect( ) ;
    let mut nums : HashSet<i32> = HashSet::new( ) ;
    for n in &numbers {
       nums.insert( *n ) ;
    }
    let mut frequencies : Vec<(i32, usize)> = Vec::new( ) ;
    for n in &nums {
       let ct = numbers.iter( ).filter( | d | *d == n ).count( ) ;
       frequencies.push( (*n , ct ) ) ;
    }
    let freqs = frequencies.as_mut_slice( ) ;
    freqs.sort_by( | a , b | { 
	  if a.1 != b.1 {
	    a.1.cmp( &b.1 ) 
	  }
	  else {
	    b.0.cmp( &a.0 )
	 }
  }) ;
  let mut output : Vec<i32> = Vec::new( ) ;
  for pair in freqs {
     for _ in 0..pair.1 {
        output.push( pair.0 ) ;
     }
  }
  println!("{:?}" , output ) ;
}
