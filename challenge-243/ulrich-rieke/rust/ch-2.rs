use std::io ;

fn main() {
    println!("Enter some integers >= 1 , separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( & mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( | s | 
	  s.trim( ).parse::<i32>().unwrap( ) ).collect( ) ;
    if numbers.iter( ).all( | n | *n == numbers[ 0 ] ) {
       println!("{}" , numbers[ 0 ] * ( numbers.len( ) as i32 ) ) ;
    }
    else {
       let len : usize = numbers.len( ) ;
       let mut sum : i32 = 0 ;
       for i in 0..len {
	  sum += numbers[ i ] / numbers[ i ] ;
	  if i < len - 1 {
	     for j in i + 1..len {
		if numbers[ i ] != numbers[ j ] {
		   let mut the_floor : i32 = ((numbers[ i ] as f32 ) / ( 
			 numbers[j ] as f32 )).floor( ) as i32 ;
		   sum += the_floor ;
		   the_floor = ((numbers[ j ] as f32 ) / ( numbers[ i ] as 
			 f32 )).floor( ) as i32 ;
		   sum += the_floor ;
		}
	     }
	  }
       }
       println!("{}" , sum ) ;
    }
}
