use std::io ;

fn main() {
    println!("Enter a number of operations!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let operations : Vec<&str> = inline.trim( ).split_whitespace( ).collect( ) ;
    let mut value : i32 = 0 ;
    for op in operations {
       if op.contains( "++" ) {
	  value += 1 ;
       }
       if op.contains( "--" ) {
	  value -= 1 ;
       }
    }
    println!("{}" , value ) ;
}
