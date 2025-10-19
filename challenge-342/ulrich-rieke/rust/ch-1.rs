use std::io ;

fn main() {
    println!("Enter a string of lowercase English letters and digits only!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let input : &str = inline.trim( ) ;
    //count the number of letters and of digits. If these differ by more than
    //one we return an empty string , otherwise we sort letters and digits. If
    //there are more digits than letters or both are equal we start with the
    //smallest digit else with the smallest letter
    let len : usize = input.chars( ).count( ) ;
    let lettercount : usize = input.chars( ).filter( |c| c.is_ascii_lowercase( )).
       count( ) ;
    let digitcount : usize = len - lettercount ;
    if (lettercount as i32).abs_diff( digitcount as i32 ) > 1 {
       println!("\"\"") ;
    }
    else {
       let mut letters : Vec<char> = Vec::new( ) ;
       let mut digits : Vec<char> = Vec::new( ) ;
       input.chars( ).filter( |c| c.is_ascii_lowercase( )).for_each( |d| letters.push( d )) ;
       input.chars( ).filter( |c| (*c).is_digit(10 )).for_each( |d| digits.push( d ) ) ;
       letters.sort( ) ;
       digits.sort( ) ;
       let mut solution : String = String::new( ) ;
       if digitcount >= lettercount {
	  while digits.len( ) > 0  {
	     solution.push( digits.remove( 0 )) ;
	     if letters.len( ) > 0 {
		solution.push( letters.remove( 0 ) ) ;
	     }
	  }
       }
       else {
	  while letters.len( ) > 0 {
	     solution.push( letters.remove( 0 ) ) ;
	     if digits.len( ) > 0 { 
		solution.push( digits.remove( 0 ) ) ;
	     }
	  }
       }
       println!("{:?}" , solution ) ;
    }
}
