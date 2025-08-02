use std::io ;

fn main() {
    println!("Enter some integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s|
	  s.parse::<i32>( ).unwrap( ) ).collect( ) ;
    println!("Enter 2 integers r and c denoting rows and columns!") ;
    let mut dimline : String = String::new( ) ;
    io::stdin( ).read_line( &mut dimline ).unwrap( ) ;
    let dimensions : Vec<usize> = dimline.trim( ).split_whitespace( ).
       map( |s| s.parse::<usize>( ).unwrap( ) ).collect( ) ;
    if dimensions[0] * dimensions[1] != numbers.len( ) {
       print!("Error! the product of rows and columns must equal") ;
       println!("the number of elements in the number vector!") ;
    }
    else {
       let mut my_array : Vec<Vec<i32>> = Vec::new( ) ;
       let mut pos : usize = 0 ;
       for _ in 0..dimensions[0] {
	  let mut row : Vec<i32> = Vec::new( ) ;
	  for _ in 0..dimensions[1] {
	     row.push( numbers[pos] ) ;
	     pos += 1 ;
	  }
	  my_array.push( row.clone( ) ) ;
       }
       println!("{:?}" , my_array ) ;
    }
}
