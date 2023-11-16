use std::io ;

fn main() {
    println!("Enter some integers , separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s | 
	  s.trim( ).parse::<i32>().unwrap( ) ).collect( ) ;
    let len = numbers.len( ) ;
    let mut sum : usize = 0 ;
    for i in 0..len - 1 {
       for j in i + 1..len {
	  if numbers[ i ] > 2 * numbers[ j ] {
	     sum += 1 ;
	  }
       }
    }
    println!("{}" , sum ) ;
}
