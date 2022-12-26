use std::io ;
use itertools::Itertools ;

fn my_rule( the_vec : &Vec<i32>  ) -> bool {
  the_vec[0] < the_vec[ 2 ] && the_vec[2] < the_vec[ 1 ]
}

fn main() {
    println!("Enter a number of integers, separated by blanks!") ;
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s |
      s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut selected : Vec<Vec<i32>> = Vec::new( ) ;
    let mut the_combis = numbers.into_iter( ).combinations( 3 ) ;
    while let Some( combi ) = the_combis.next( ) {
      if my_rule( &combi ) {
      selected.push( combi ) ;
      }
    }
    if selected.len( ) > 0 {
      println!("{:?}" , selected[0] ) ;
    }
    else {
      println!("()" ) ;
    }
}
