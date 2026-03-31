fn rearrange( binary : &str ) -> String {
   let len : usize = binary.chars( ).count( ) ;
   let ones : usize = binary.chars( ).filter( |&c| c == '1' ).count( ) ;
   let mut output : String = String::new( ) ;
   output.push( '1' ) ;
   for _ in 0..len - ones {
      output.insert( 0 , '0' ) ;
   }
   for _ in 0..ones - 1 {
      output.insert( 0 , '1' ) ;
   }
   output
}

fn main() {
    println!("{:?}" , rearrange( "1011"));
    println!("{:?}" , rearrange( "100" )) ;
    println!("{:?}" , rearrange("111000")) ;
    println!("{:?}" , rearrange( "0101" )) ;
    println!("{:?}" , rearrange( "1111") ) ;
}
