use std::io ;

fn main() {
    println!("Enter some integers or letters D , C or + separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entrystrings : Vec<&str> = inline.trim( ).split_whitespace( ).collect( );
    let mut numbers : Vec<i32> = Vec::new( ) ;
    if let Some( pos ) = entrystrings.iter( ).position( |s| ! s.parse::<i32>( ).
	  is_ok( ) ) {
       if pos < entrystrings.len( ) {
	  entrystrings.iter( ).take( pos ).map( |s| s.parse::<i32>( ).unwrap( )).
	     for_each( |n| numbers.push( n ) ) ;
	  let len : usize = entrystrings.len( ) ;
	  for p in pos..len {
	     let value : &str = entrystrings[p] ;
	     if value == "C" {
		numbers.remove( numbers.len( ) - 1 ) ;
	     }
	     if value == "D" {
		let l = numbers.len( ) ;
		numbers.push( numbers[l - 1] * 2 ) ;
	     }
	     if value == "+" {
		let l = numbers.len( ) ;
		numbers.push( numbers[l - 2] + numbers[l - 1] ) ;
	     }
	     if value.chars( ).count( ) >= 2 {
		let num : i32 = value.parse::<i32>( ).unwrap( ) ;
		numbers.push( num ) ;
	     }
	     if value.chars( ).count( ) == 1 && value.chars( ).nth( 0 ).unwrap( ).
		is_ascii_digit( ) {
		   let num : i32 = value.parse::<i32>( ).unwrap( ) ;
		   numbers.push( num ) ;
	     }
	  }
       }
       else {
       }
       println!("{}" , numbers.into_iter( ).sum::<i32>( ) ) ;
    }
    else {
       for s in entrystrings {
	  numbers.push( s.parse::<i32>( ).unwrap( )) ;
       }
       println!("{}" , numbers.into_iter( ).sum::<i32>( ) ) ;
    }
}
