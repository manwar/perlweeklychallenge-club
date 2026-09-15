use std::io ;
use itertools::Itertools ;

fn main() {
    println!("Enter a first array of integers!");
    let mut firstline : String = String::new( ) ;
    io::stdin( ).read_line( &mut firstline ).unwrap( ) ;
    let firstarray : Vec<i32> = firstline.trim( ).split_whitespace( ).
       map( |s| s.parse::<i32>().unwrap( ) ).collect( ) ;
    println!("Enter a second array of integers!") ;
    let mut secondline : String = String::new( ) ;
    io::stdin( ).read_line( &mut secondline ).unwrap( ) ;
    let secondarray : Vec<i32> = secondline.trim( ).split_whitespace( ).
       map( |s| s.parse::<i32>().unwrap( ) ).collect( ) ;
    //both array are sorted , so we can merge them with a result 
    //sorted array 
    let finalarray : Vec<i32> = firstarray.into_iter().merge( secondarray ).
       collect( ) ;
    let len : usize = finalarray.len( ) ;
    if len % 2 == 1 {
       println!("{}" , finalarray[ len / 2 ] ) 
    }
    else {
       println!("{}" , (finalarray[len / 2 - 1] as f32 + finalarray[len / 2 ]
             as f32) / 2 as f32 ) ;
    }
}
