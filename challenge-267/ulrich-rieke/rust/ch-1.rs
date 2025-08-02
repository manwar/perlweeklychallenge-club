use std::io ;

fn main() {
    println!("Enter some integers,separated by ',' !");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.trim( ).split( ',' ).map( | s |
	  s.parse::<i32>( ).unwrap( )).collect( ) ;
    let prod : i32 = numbers.into_iter( ).product( ) ;
    let sign : i8 = match prod {
       value if value < 0 => -1 ,
       value if value == 0 => 0 ,
       _                   => 1 
    } ;
    println!("{}" , sign ) ;
}
