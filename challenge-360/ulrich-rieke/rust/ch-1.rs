fn main() {
   use std::io ;
    println!("Enter a word!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let word : &str = inline.trim_end( ) ;
    println!( "Enter a width!" ) ;
    let mut wline : String = String::new( ) ;
    io::stdin( ).read_line( &mut wline ).unwrap( ) ;
    let width : usize = wline.trim_end( ).parse::<usize>( ).unwrap( ) ;
    let mut output : String = String::new( ) ;
    let len : usize = word.chars( ).count( ) ;
    if len == 0 {
       for _ in 0..width {
          output.push( '*' ) ;
       }
    }
    else {
       let left_edge : usize = (width - len) / 2 ;
       for _ in 0..left_edge {
          output.push('*') ;
       }
       output.push_str( word.into( ) ) ;
       for _ in 0..width - len - left_edge {
          output.push( '*' ) ;
       }
    }
    println!("{:?}" , output ) ;
}
