use std::io ;

fn main() {
    println!("Enter an alphanumeric string!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let word : &str = inline.trim( ) ;
    let mut numbers : Vec<u32> = Vec::new( ) ;
    for c in word.chars( ) {
       if c.to_digit( 10 ).is_some( ) {
          let n : u32 = c.to_digit( 10 ).unwrap( ) ;
          if ! numbers.contains( &n ) {
             numbers.push( n ) ;
          }
       }
    }
    let len : usize = numbers.len( ) ;
    if len == 0 || len == 1 {
       println!("-1" ) ;
    }
    else {
       numbers.sort_by( |a , b| b.cmp( a ) ) ;
       println!("{}" , numbers[1] ) ;
    }
}
