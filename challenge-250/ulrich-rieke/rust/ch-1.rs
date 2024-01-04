use std::io ;

fn main() {
    println!("Enter some integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s |
	  s.trim( ).parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut selected : Vec<usize> = Vec::new( ) ;
    let len = numbers.len( ) ;
    for i in 0..len {
       if i % 10 == numbers[ i ] as usize {
	  selected.push( i ) ;
       }
    }
    if selected.len( ) > 0 {
       println!("{}" , selected.iter( ).min( ).unwrap( ) ) ;
    }
    else {
       println!("-1") ;
    }
}
