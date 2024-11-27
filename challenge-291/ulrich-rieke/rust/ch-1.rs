use std::io ;

fn main() {
    println!("Enter some integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = inline.as_str( ).trim( ) ;
    let numbers : Vec<i32> = entered_line.split_whitespace( ).map( |s| 
	  s.parse::<i32>( ).unwrap( )).collect( ) ;
    let len = numbers.len( ) ;
    if len == 1 {
       println!("{}" , 0) ;
    }
    else {
       let mut result : i16 = -1 ;
       let vec_slice = &numbers[..] ;
       for i in 0..len {
	  let left_sum : i32 ;
	  let right_sum : i32 ;
	  let ( left_array , right_array ) = vec_slice.split_at( i ) ;
	  if left_array.len( ) == 0 {
	     left_sum = 0 ;
	  }
	  else {
	     left_sum = left_array[..i].iter( ).sum::<i32>( ) ;
	  }
	  if right_array.len( ) == 0 {
	     right_sum = 0 ;
	  }
	  else {
	     right_sum = right_array[1..].iter( ).sum::<i32>( ) ;
	  }
	  if left_sum == right_sum {
	     result = i as i16 ;
	     break ;
	  }
       }
       println!("{}" , result ) ;
    }
}
