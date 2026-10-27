use std::io ;

fn main() {
    println!("Enter some integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace( ).
       map( |s| s.parse::<i32>( ).unwrap( )).collect( ) ;
    let average : f32 = numbers.iter( ).sum::<i32>( ) as f32 / (numbers.len( )
          as f32 ) ;
    let mut current : i32 = if average.ceil( ) == average {
       (average as i32) + 1
    }
    else {
       let avg : f32 = average.ceil( ) ;
       if avg < 0.0 {
          (avg as i32) + 1
       }
       else {
          avg as i32
       }
    } ;
    while current <= 0 {
       current += 1 ;
    }
    while numbers.contains( &current ) {
       current += 1 ;
    }
    println!("{}" , current ) ;
}
