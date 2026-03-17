fn solution( input : &str ) -> String {
   let result : String = input.replace( "()" , "o" ) ;
   let secondresult : String = result.as_str( ).replace( "(al)" , "al" ) ;
   secondresult 
}

fn main() {
    println!("{:?}" , solution( "G()(al)")) ;
    println!("{:?}" , solution( "G()()()()(al)" )) ;
    println!("{:?}" , solution( "(al)G(al)()()" )) ;
    println!("{:?}" , solution("()G()G" ) ) ;
    println!("{:?}" , solution( "(al)(al)G()()" )) ;
}
