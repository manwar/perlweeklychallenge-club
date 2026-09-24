use std::io ;
use itertools::Itertools ;

//no common characters
fn condition( terms : &Vec<&str> ) -> bool {
   terms[0].chars().all( |c| terms[1].chars( ).position( |d| d == c ).
         is_none( ) )
}

fn main() {
    println!("Enter some strings separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let strings : Vec<&str> = inline.trim( ).split_whitespace( ).collect( );
    let mut iter = strings.into_iter( ).combinations( 2 ) ;
    let mut maxi : usize = 0 ;
    while let Some( v ) = iter.next( ) {
       if condition( &v ) {
          let current : usize = v[0].chars( ).count( ) * v[1].chars( ).
             count( ) ;
          if current > maxi {
             maxi = current ;
          }
       }
    }
    println!("{}" , maxi ) ;
}
