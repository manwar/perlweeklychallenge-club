use std::io ;

fn main() {
    println!("Enter some integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( |s|
	  s.parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut result : bool = false ;
    let len = numbers.len( ) ;
    for n in 0..len - 1 {
       if numbers[n] > 1 {
	  for i in n + 1 ..len {
	     if numbers[n] == 2 * numbers[i] {
		result = true ;
		break ;
	     }
	  }
       }
    }
    println!("{}" , result ) ;
}
