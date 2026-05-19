use std::io ;

fn main() {
    println!("Enter some integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( & mut inline ).unwrap( ) ;
    println!("Enter a positive integer!" ) ;
    let mut numberline : String = String::new( ) ;
    io::stdin( ).read_line( &mut numberline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s|
          s.parse::<i32>( ).unwrap( )).collect( ) ;
    let num : i32 = numberline.trim( ).parse::<i32>( ).unwrap( ) ;
    let len : i32 = numbers.len( ) as i32 ;
    let total : i32 = len / num ;
    let remainder : i32 = len % num ;
    if total == 0 {
       println!("-1") ;
    }
    else {
       let mut solution : Vec<_> ;
       if remainder != 0 {
          let slice = &numbers[..(remainder * ( total + 1 )) as usize] ;
          solution = slice.chunks( (total + 1) as usize ).collect( ) ;
          let nextslice = &numbers[(remainder * (total + 1))as usize ..] ;
          let mut niter = nextslice.chunks( total as usize ) ;
          while let Some( chun ) = niter.next( ) {
             solution.push( chun ) ;
          }
       }
       else {
          let slice = &numbers[..] ;
          solution = slice.chunks( total as usize ).collect( ) ;
       }
       println!("{:?}" , solution ) ;
    }
}
