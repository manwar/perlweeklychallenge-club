use std::io ;

fn main() {
    println!("Enter some integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s|
          s.parse::<i32>( ).unwrap( ) ).collect( ) ;
    let mut differences : Vec<i32> = Vec::new( ) ;
    let len : usize = numbers.len( ) ;
    for i in 0..len - 1 {
       differences.push( numbers[i] - numbers[i + 1] ) ;
    }
    if differences.iter( ).any( |n| *n == 0 ) {
       println!("false" ) ;
    }
    else {
       let first_part : Vec<&i32> = differences.iter( ).take_while( |n|
             **n < 0 ).collect( ) ;
       let second_part : Vec<&i32> = differences.iter( ).skip( 
             first_part.len( ) ).take_while( |n| **n > 0 ).collect( ) ;
       let third_part : Vec<&i32> = differences.iter( ).skip( first_part.len( )
             + second_part.len( )).take_while( |n| **n < 0 ).collect( ) ;
       println!("{}" , first_part.len( ) + second_part.len( ) + 
             third_part.len( ) == differences.len( ) && first_part.len( ) > 0
             && second_part.len( ) > 0 && third_part.len( ) > 0 ) ;
    }
}
