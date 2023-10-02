use std::io ;

fn main() {
    println!("Enter some integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s |
      s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut for_sorting : Vec<i32> = numbers.clone( ) ;
    for_sorting.sort( ) ;
    let len : usize = numbers.len( ) ;
    let mut same_pos : usize = 0 ;
    for i in 0..len {
      if numbers[ i ] == for_sorting[ i ] {
      same_pos += 1 ;
      }
    }
    println!("{}" , same_pos ) ;
}
