use std::io ;

fn main() {
    println!("Enter some 0 or 1 , separated by blanks!");
    println!("Enter as many rows as there are numbers in the first row!") ;
    let mut matrix : Vec<Vec<u8>> = Vec::new( ) ;
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let first_nums : Vec<u8> = entered_line.split_whitespace( ).map( | s |
	  s.trim( ).parse::<u8>( ).unwrap( )).collect( ) ;
    let len = first_nums.len( ) ;
    matrix.push( first_nums ) ;
    let mut counter : usize = 0 ;
    while counter != len - 1 {
       println!("Enter some more 0 and 1 , separated by blanks!") ;
       let mut next_line : String = String::new( ) ;
       io::stdin( ).read_line( &mut next_line ).unwrap( ) ;
       let num_line : &str = &*next_line ;
       let nums : Vec<u8> = num_line.split_whitespace( ).map( | s |
	     s.trim( ).parse::<u8>( ).unwrap( ) ).collect( ) ;
       matrix.push( nums ) ;
       counter += 1 ;
    }
    let mut new_matrix : Vec<Vec<u8>> = Vec::new( ) ;
    for v in &mut matrix {
       let sl = v.as_mut_slice( ) ;
       sl.reverse( ) ;
       let mut changed = sl.to_vec( ) ;
       for i in 0..len {
	  if changed[ i ] == 0 {
	     changed[ i ] = 1 ;
	  }
	  else {
	     changed[ i ] = 0 ;
	  }
       }
       new_matrix.push( changed ) ;
    }
    println!("{:?}" , new_matrix ) ;
}
