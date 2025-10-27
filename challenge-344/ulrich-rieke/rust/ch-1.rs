use std::io ;

fn decompose( mut number : u32 ) -> Vec<u32> {
   let mut digits : Vec<u32> = Vec::new( ) ;
   while number != 0 {
      digits.push( number % 10 ) ;
      number /= 10 ;
   }
   let result : Vec<u32> = digits.into_iter( ).rev( ).collect( ) ;
   result 
}

fn main() {
    println!("Enter some integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( & mut inline ).unwrap( ) ;
    let digits : Vec<u32> = inline.trim( ).split_whitespace( ).map( 
	  |s| s.parse::<u32>( ).unwrap( )).collect( ) ;
    println!("Enter an integer!") ;
    inline.clear( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let number : u32 = inline.trim( ).parse::<u32>().unwrap( ) ;
    let mut total : u32 = 0 ;
    let changed_order : Vec<u32> = digits.into_iter( ).rev( ).collect( ) ;
    let mut pos : u32 = 0 ;
    changed_order.into_iter( ).map( |d| {
	  let value : u32 = d * 10u32.pow( pos ) ;
	  pos += 1 ;
	  value }).for_each( |n| total += n ) ;
    let result : u32 = total + number ;
    println!("{:?}" , decompose( result ) ) ;
}
