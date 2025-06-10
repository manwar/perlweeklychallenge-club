use std::io ;

fn main() {
    println!("Enter some item prices separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let prices : Vec<u32> = inline.trim( ).split_whitespace( ).map( |s|
	  s.parse::<u32>( ).unwrap( ) ).collect() ;
    let len : usize = prices.len( ) ;
    let mut solution : Vec<u32> = Vec::new( ) ;
    for n in 0..len - 1 {
       let mut followers : Vec<u32> = Vec::new( ) ;
       for c in n + 1 .. len {
	  if prices[c] <= prices[n] {
	     followers.push( prices[c] ) ;
	  }
       }
       if followers.len( ) == 0 {
	  solution.push( prices[n] ) ;
       }
       else {
	  solution.push( prices[n] - followers[0] ) ;
       }
    }
    solution.push( prices[len - 1] ) ;
    println!("{:?}" , solution ) ;
}
