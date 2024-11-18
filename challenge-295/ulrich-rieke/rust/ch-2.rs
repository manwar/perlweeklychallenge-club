use std::io ;

fn is_neighbouring( first_vec : &Vec<usize> , second_vec : &Vec<usize> ) 
   -> bool {
      use std::collections::HashSet ;
      let mut first_set : HashSet<_> = HashSet::new( ) ;
      let mut second_set : HashSet<_> = HashSet::new( ) ;
      for i in first_vec {
	 first_set.insert( *i ) ;
      }
      for i in second_vec {
	 second_set.insert( *i ) ;
      }
      let common = &first_set & &second_set ;
      common.len( ) > 0 
}

fn main() {
    println!("Enter some positive integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<u32> = inline.trim( ).split_whitespace( ).map( 
	  |s| s.parse::<u32>( ).unwrap( ) ).collect( ) ;
    let len = numbers.len( ) ;
    if numbers[0] == 0 { // we can't jump
       println!("-1" ) ;
    }
    else { //we jump to the end in one move!
       if numbers[0] as usize >= len - 1 {
	  println!("1") ;
       }
       else {
	  //indices for the list of indices at every position in the vector
	  let mut indices : Vec<Vec<usize>> = Vec::new( ) ;
	  let mut current_indices : Vec<usize> = Vec::new( ) ;
	  for i in 0..len - 1 {
	     if numbers[i] == 0 {
		current_indices.push( i ) ;
	     }
	     else {
		for p in 0..=numbers[i] {
		   current_indices.push( i + p as usize  ) ;
		}
	     }
	     indices.push( current_indices.clone( ) ) ;
	     current_indices.clear( ) ;
	  }
	  //neighbours contains all vectors that are neighbouring in the 
	  //sense of the above function
	  let mut neighbours : Vec<Vec<usize>> = Vec::new( ) ;
	  neighbours.push( indices[0].clone( ) ) ;
	  for i in 1..len - 1 {
		if neighbours.last( ).unwrap( ).contains( &(len - 1) ) {
		break ;
	     }
	     if indices[i].len( ) > 1 &&
		is_neighbouring( &neighbours.last( ).unwrap( ) ,
		   &indices[i] ) {
		neighbours.push( indices[i].clone( ) ) ;
	     }
	  }
	  if ! neighbours.last( ).unwrap( ).contains( &(len - 1 ) ) {
	     println!("-1" ) ;//we couldn't go to the end
	  }
	  else {
	     println!("{}" , neighbours.len( ) ) ;
	  }
       }
    }
}
