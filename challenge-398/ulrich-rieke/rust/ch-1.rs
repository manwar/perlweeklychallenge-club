use std::io ;

fn main() {
    println!("Enter some positive integers!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace().map( |s|
          s.parse::<i32>().unwrap( )).collect( ) ;
    let selected : Vec<i32> = numbers.into_iter( ).filter( |&n| n % 2 == 0
          && n % 3 == 0 ).collect( ) ;
    let len : usize = selected.len( ) ;
    if len == 0 {
       println!("0" ) ;
    }
    else {
       let avg : f32 = (selected.iter().sum::<i32>( ) as f32) /
          (len as f32) ;
       println!("{}" , avg.round( ) as i32 ) ;
    }
}
