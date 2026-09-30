use std::io ;

fn main() {
    println!("Please enter a positive integer!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let limit : u32 = inline.trim( ).parse::<u32>( ).unwrap( ) ;
    let mut total : usize = 0 ;
    for a in 1..= limit {
       for b in 1..= limit {
          for c in 1..= limit {
             if a.pow( 2 ) + b.pow( 2 ) == c.pow( 2 ) {
                total += 1 ;
             }
          }
       }
    }
    println!("{}" , total ) ;
}
