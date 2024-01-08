use itertools::Itertools ;
use std::io ;

fn is_valid( permu : &Vec<usize> , i_positions : &Vec<usize> , 
      d_positions : &Vec<usize> ) -> bool {
   for n in i_positions {
      if permu[*n] >= permu[ *n + 1 ] {
	 return false ;
      }
   }
   for d in d_positions {
      if permu[*d] <= permu[ *d + 1 ] {
	 return false ;
      }
   }
   true
}

fn main() {
    println!("Enter a string consisting of capital I and D only!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let trimmed = entered_line.trim( ) ;
    let len = trimmed.chars( ).count( ) ;
    let mut the_is : Vec<usize> = Vec::new( ) ;
    let mut the_ds : Vec<usize> = Vec::new( ) ;
    trimmed.chars( ).enumerate( ).for_each( | x | {
	  if x.1 == 'I' {
	     the_is.push( x.0 ) ;
	  }
	  else {
	     the_ds.push( x.0 ) ;
	  }
	} ) ;
    for v in (0..=len).permutations( len + 1 ) {
       if is_valid( &v , &the_is , &the_ds ) {
	  println!("{:?}" , v ) ;
	  break ;
       }
    }
}
