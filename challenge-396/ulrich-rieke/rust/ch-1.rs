use std::io ;

fn main() {
    println!("Enter n integers from 1 to n in any order!");
    let mut intline : String = String::new( ) ;
    io::stdin( ).read_line( &mut intline ).unwrap( ) ;
    println!("Enter a subset of these numbers in strictly increasing order!") ;
    let mut idline : String = String::new( ) ;
    io::stdin( ).read_line( &mut idline ).unwrap( ) ;
    let order : Vec<i32> = intline.trim( ).split_whitespace( ).map( |s|
          s.parse::<i32>().unwrap( ) ).collect( ) ;
    let friends : Vec<i32> = idline.trim( ).split_whitespace( ).map( |s|
          s.parse::<i32>().unwrap( )).collect( ) ;
    let numberpositions : Vec<(usize , i32)> = order.into_iter( ).enumerate( ).
       collect( ) ;
    let mut reordered : Vec<&(usize , i32)> = friends.iter( ).map( |i| {
          let pair = numberpositions.iter( ).find( |p| p.1 == *i ).unwrap( ) ;
          pair
          } ).collect( ) ;
    reordered.sort_by_key( |p| p.0 ) ;
    println!("{:?}" , reordered.into_iter( ).map( |p| p.1 ).collect::<Vec<i32>>
          ( ) ) ;
}
