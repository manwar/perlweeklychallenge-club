use std::io ;

fn main() {
    println!("Enter a string!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered : &str = inline.trim( ) ;
    let mut reversed : String = String::new( ) ;
    let mut current : usize = entered.chars( ).count( ) ;
    if current == 0 {
       println!("\"\"" ) ;
    }
    else {
       current -= 1 ;
       while current != 0 {
          let c : char = entered.chars( ).nth( current ).unwrap( ) ;
          reversed.push( c ) ;
          current -= 1 ;
       }
       let c = entered.chars( ).nth( 0 ).unwrap( ) ;
       reversed.push( c ) ;
       println!("{:?}" , reversed ) ;
    }
}
