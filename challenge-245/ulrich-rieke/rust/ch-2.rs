use std::io ;
use itertools::Itertools ;

fn concatenate( nums : Vec<&u32> ) -> u32 {
   let mut total : String = String::new( ) ;
   for n in nums {
      let str : String = (*n).to_string( ) ;
      total.push_str( &str ) ;
   }
   let numberstr : &str = total.as_str( ) ;
   numberstr.parse::<u32>().unwrap( ) 
}

fn main() {
    println!("Enter some integers greater than 0 , separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<u32> = entered_line.split_whitespace( ).map( | s | 
	  s.trim( ).parse::<u32>( ).unwrap( ) ).collect( ) ;
    let len = numbers.len( ) ;
    let mut selected : Vec<u32> = Vec::new( ) ;
    let mut i : usize = len ;
    while i != 1 {
       let perms = numbers.iter( ).permutations( i ) ;
       let mut permuted : Vec<u32> = Vec::new( ) ;
       for vec in perms {
	  let concat : u32 = concatenate( vec ) ;
	  permuted.push( concat ) ;
       }
       permuted.iter( ).filter( | n | *n % 3 == 0 ).for_each( | num | 
	     selected.push( *num ) ) ;
       if selected.len( ) > 0 {
	  selected.sort_by( | a , b | b.cmp( a ) ) ;
	  break ;
       }
       i -= 1 ;
    }
    if selected.len( ) > 0 {
       println!("{}" , selected[0] ) ;
    }
    else {
       println!("-1") ;
    }
}
