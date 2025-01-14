use std::io ;

fn find_average( numbers : &&[i32] ) -> f32 {
   let mut total : i32 = 0 ;
   let len : usize = numbers.len( ) ;
   for i in 0..len {
      total += numbers[i] ;
   }
   let len : usize = numbers.len( ) ;
   let average : f32 = (total as f32) / (len as f32 ) ;
   average
}

fn main() {
    println!("Enter some integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s|
	  s.parse::<i32>( ).unwrap( ) ).collect( ) ;
    println!("Enter a number smaller or equal than the length of the array!") ;
    let mut numline : String = String::new( ) ;
    io::stdin( ).read_line( &mut numline ).unwrap( ) ;
    let n : usize = numline.trim( ).parse::<usize>( ).unwrap( ) ;
    let numberslice = &numbers[..] ;
    let mut iter = numberslice.windows( n ) ;
    let mut firsttime : bool = true ;
    let mut maxi : f32 = *numbers.iter( ).min( ).unwrap( ) as f32 ;
    while let Some( vec ) = iter.next( ) {
       let avg : f32 = find_average( &vec ) ;
       if firsttime {
	  maxi = avg ;
	  firsttime = false ;
       }
       else {
	  if avg > maxi {
	     maxi = avg ;
	  }
       }
    }
    println!("{}" , maxi ) ;
}
