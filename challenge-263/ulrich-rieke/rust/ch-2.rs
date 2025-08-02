use std::io ;
use itertools::Itertools ;

fn main() {
    println!("Enter an even number of integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let first_nums : Vec<i32> = entered_line.split_whitespace( ).map( | s |
	  s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    println!("Once again, enter an even number of integers!") ;
    let mut secline : String = String::new( ) ;
    io::stdin( ).read_line( &mut secline ).unwrap( ) ;
    let newline : &str = &*secline ;
    let second_nums : Vec<i32> = newline.split_whitespace( ).map( | s | 
	  s.trim( ).parse::<i32>().unwrap( ) ).collect( ) ;
    let first_pairs = first_nums.into_iter( ).tuples( ).collect( ) ;
    let second_pairs : Vec<(i32, i32)> = second_nums.into_iter( )
       .tuples( ).collect( ) ;
    let mut all_pairs : Vec<(i32 , i32)> = first_pairs ;
    for elt in second_pairs {
       all_pairs.push( elt ) ;
    }
    let lookup = all_pairs.into_iter( ).into_group_map( ) ;
    let mut merged_pairs = Vec::new( ) ;
    for ( k , v ) in lookup {
       merged_pairs.push( (k , v.iter( ).sum::<i32>( ) ) ) ;
    }
    let slice = &mut merged_pairs[..] ;
    slice.sort_by( | a , b | a.0.cmp( &b.0 ) ) ;
    println!("{:?}" , slice ) ;
}
