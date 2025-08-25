use std::io ;
use std::collections::HashSet ;

fn main() {
    println!("Enter some integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s| 
	  s.parse::<i32>( ).unwrap( )).collect( ) ;
    let mut uniques : HashSet<i32> = HashSet::new( ) ;
    for n in &numbers {
       uniques.insert(*n ) ;
    }
    let mut numfrequencies : Vec<(i32, usize)> = Vec::new( ) ;
    for n in &uniques {
       numfrequencies.push( (*n , numbers.iter( ).filter( |&d| *d == *n ).count( )) ) ;
    }
    let result : bool  ;
    if uniques.len( ) == 1 {
       result = numbers.len( ) > 1 ;
    }
    else {
       let freq_slice = &mut numfrequencies[..] ;
       freq_slice.sort_by( |a , b| a.1.cmp( &b.1 ) ) ;
       let mini : usize = freq_slice[0].1 ;
       result = mini > 1 && freq_slice.into_iter( ).skip( 1 ).map( |p| p.1 )
	  .all( |n| n % mini == 0 ) ;
    }
    println!("{}" , result ) ;
}
