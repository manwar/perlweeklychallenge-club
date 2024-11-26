use std::io ;

fn main() {
    println!("Enter some numbers 0 and 1!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<u8> = inline.trim( ).split_whitespace( ).map( |s|
	  s.parse::<u8>( ).unwrap( ) ).collect( ) ;
    let len : usize = numbers.len( ) ;
    let first : u8 = numbers[0] ;
    if numbers.iter( ).all( |n| *n == first ) {
       println!("0") ;
    }
    else {
       let mut pairs : Vec<(usize, usize)> = Vec::new( ) ;
       for start in 0..len - 1 {
	  for end in start + 1 .. len {
	     let count_ones : &usize = &numbers[start..=end].iter( ).
		filter( |&d| *d == 1 ).count( ) ;
	     let count_zeroes : usize = end + 1 - start - *count_ones ;
	     pairs.push( (count_zeroes , *count_ones) ) ;
	  }
       }
       let mut selected : Vec<(usize , usize)> = pairs.into_iter( ).
	  filter( |&p| p.0 == p.1 ).collect( ) ;
       selected.sort_by( |a , b| a.0.cmp( &b.0 ) ) ;
       let len2 = selected.len( ) ;
       if  len2 > 0 {
	  println!("{}" , selected[len2 - 1].0 + selected[len2 - 1].1 ) ;
       }
       else {
	  println!("0") ;
       }
    }
}
