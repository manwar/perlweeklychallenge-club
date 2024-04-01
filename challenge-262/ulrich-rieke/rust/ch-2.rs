use std::io ;
use itertools::Itertools ;

fn main() {
    println!("Enter some integers, separated by whitespace!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s |
	  s.trim( ).parse::<i32>().unwrap( )).collect( ) ;
    println!("Enter an integer!") ;
    let mut numline : String = String::new( ) ;
    io::stdin( ).read_line( &mut numline ).unwrap( ) ;
    let numberline : &str = &*numline ;
    let k : i32 = numberline.trim( ).parse::<i32>( ).unwrap( ) ;
    let mut sum : usize = 0 ;
    let len : usize = numbers.len( ) ;
    let it = (0..len).combinations( 2 ) ;
    for v in it {
      let fst = v[0] ;
      let snd = v[1] ;
      if numbers[ fst ] == numbers[ snd ] && ((fst * snd) as i32 ) % k == 0 {
	 sum = sum + 1 ;
      }
    }
    println!("{}" , sum ) ;
}
