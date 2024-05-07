use std::io ;
use std::collections::HashMap ;
use std::collections::hash_map::Entry ;

fn main() {
    println!("Enter a string!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    println!("Enter 26 positive numbers, denoting the widths!") ;
    let mut sec_line : String = String::new( ) ;
    io::stdin( ).read_line( &mut sec_line ).unwrap( ) ;
    let width_line : &str = &*sec_line ;
    let characters : &str = "abcdefghijklmnopqrstuvwxyz" ;
    let widths : Vec<usize> = width_line.split(',' ).map( | s | 
	  s.trim( ).parse::<usize>( ).unwrap( ) ).collect( ) ;
    let mut sum : usize = 0 ;
    let mut char_widths : HashMap<char, usize> = HashMap::new( ) ;
    characters.chars( ).zip( widths.iter( )).for_each( | x | {
	  if let Entry::Vacant( o ) = char_widths.entry( x.0 ) {
	    o.insert( *x.1 ) ;
	  }
	  }) ; 
    let trimmed : &str = entered_line.trim( ) ;
    let mut linesum : usize = 1 ;
    let pixels : usize ;
    for ch in trimmed.chars( ) {
       sum += char_widths.get( &ch ).unwrap( ) ;
       if sum > 100 {
	  linesum += 1 ;
	  sum = *char_widths.get( &ch ).unwrap( ) ;
       }
       if sum == 100 {
	  linesum += 1 ;
	  sum = 0 ;
       }
    }
    if sum == 0 { //no remaining pixels, we must reduce line number
       linesum -= 1 ;
    }
    pixels = sum ;
    println!("({} , {})" , linesum , pixels ) ;
}
