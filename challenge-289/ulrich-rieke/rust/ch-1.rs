use std::io ;
use std::collections::HashSet ;

fn main() {
    println!("Enter some integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( |s| 
	  s.parse::<i32>().unwrap( ) ).collect( ) ;
    if numbers.len( ) < 3 {
       println!("{}" , numbers.into_iter( ).max( ).unwrap( ) ) ;
    }
    else {
       let mut uniques : HashSet<i32> = HashSet::new( ) ;
       for n in numbers {
	  uniques.insert( n ) ;
       }
       let mut for_sorting : Vec<i32> = Vec::new( ) ;
       for n in uniques {
	  for_sorting.push( n ) ;
       }
       let len = for_sorting.len( ) ;
       if len < 3 {
	  println!("{}" , for_sorting.into_iter( ).max( ).unwrap( ) ) ;
       }
       else {
	  for_sorting.sort( ) ;
          println!("{}" , for_sorting[len - 3]) ;
       }
    }
}
