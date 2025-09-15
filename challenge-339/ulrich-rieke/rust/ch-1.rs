use std::io ;

fn main() {
    println!("Enter an array of integers with 4 or more numbers!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let mut numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( 
	  |s| s.parse::<i32>( ).unwrap( ) ).collect( ) ;
    let len : usize = numbers.len( ) ;
    //if all numbers are greater than 0 or smaller than 0 we sort 
    //depending on the case we form pairs of the smallest or the greatest
    //of these sorted numbers and subtract
    let all_positive : bool = numbers.iter( ).all( |d| *d >= 0 ) ;
    let all_negative : bool = numbers.iter( ).all( |d| *d < 0 ) ;
    if all_positive || all_negative {
       numbers.sort( ) ;
       if all_positive {
	  println!("{}" , numbers[len - 2] * numbers[len - 1] - 
		numbers[0] * numbers[1] ) ;
       }
       if all_negative {
	  println!("{}" , numbers[0] * numbers[1] - numbers[len - 2] * 
		numbers[len - 1] ) ;
       }
    }
    else { //different signs!
       numbers.sort_by_key( |d| d.abs( ) ) ;
       println!("{}" , numbers[0] * numbers[1] - numbers[len - 2] *
	     numbers[len - 1] ) ;
    }
}
