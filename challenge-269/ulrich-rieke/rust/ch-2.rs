use std::io ;

fn main() {
    println!("Enter some distinct integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let mut numbers : Vec<i32> = entered_line.trim( ).split_whitespace( ).
       map( | s | s.parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut arr1 : Vec<i32> = Vec::new( ) ;
    let mut arr2 : Vec<i32> = Vec::new( ) ;
    let mut first : i32 = numbers.remove( 0 ) ;
    arr1.push( first ) ;
    first = numbers.remove( 0 ) ;
    arr2.push( first ) ;
    while numbers.len( ) > 0 {
       let len1 = arr1.len( ) ;
       let len2 = arr2.len( ) ;
       first = numbers.remove( 0 ) ;
       if arr1[len1 - 1] > arr2[len2 - 1] {
	  arr1.push( first ) ;
       }
       else {
	  arr2.push( first ) ;
       }
    }
    for i in arr2 {
       arr1.push( i ) ;
    }
    println!("{:?}" , arr1 ) ;
}
