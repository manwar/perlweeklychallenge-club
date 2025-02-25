use std::io ;
use itertools::Itertools ;

fn main() {
    println!("Enter some 0 and 1 separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let binaries : Vec<u8> = inline.trim( ).split_whitespace( ).map( |s|
	  s.parse::<u8>( ).unwrap( ) ).collect( ) ;
    println!("Enter a positive number!" ) ;
    let mut numline : String = String::new( ) ;
    io::stdin( ).read_line( &mut numline ).unwrap( ) ;
    let num : usize = numline.trim( ).parse::<usize>( ).unwrap( ) ;
    let len : usize = binaries.len( ) ;
    if len == 1 {
       println!("false") ;
    }
    else {//if there are 2 neighbouring 1 it must be false!
       let onepositions : Vec<usize> = binaries.iter( ).positions( |n| *n == 1 ).
	  collect( );
       if onepositions.as_slice( ).windows( 2 ).any( |v| (v[0] as i16).abs_diff(
		v[1] as i16) == 1 ) {
	  println!("false") ;
       }
       //now we create an alternating sequence of 0 and 1 by calling the 
       //cycle iterator adaptor
       //we start with (0 , 1 ) if there are no 1's in the array entered or
       //if the first 1 is at an uneven position
       else {
	  let alternating : Vec<u8> = match binaries.iter( ).position(|d| *d == 
		1 ) {
	     Some( pos ) => {
		let startvec : Vec<u8> ;
		if pos % 2 == 0 {
		   startvec = vec![1 , 0] ;
		}
		else {
		   startvec = vec![0 , 1] ;
		}
		startvec.into_iter( ).cycle( ).take( len ).collect( ) 
	     } , 
	     None => {
		let startvec : Vec<u8> = vec![0 , 1] ;
		startvec.into_iter( ).cycle( ).take( len ).collect( ) 
	     }
	  } ;
	  let mut iter = binaries.iter( ).zip( alternating.iter( ) ) ;
	  let mut flipped : usize = 0 ;
	  //we count the number of times an initial 0 is flipped to 1
	  while let Some( tuple ) = iter.next( ) {
	     if *tuple.0 == 0 && *tuple.1 == 1 {
		flipped += 1 ;
	     }
	  }
	  //the number of flips must be greater than or equal than the initial
	  //num!
	  println!("{}" , flipped >= num ) ;
       }
   }
}
