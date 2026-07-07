use std::io ;

fn main() {
    println!("Enter some integers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s|
          s.parse::<i32>().unwrap( )).collect( ) ;
    let len : usize = numbers.len( ) ;
    if len < 3 {
       println!("0" ) ;
    }
    else {
       let selected : Vec<&i32> = numbers.iter( ).filter( |n| {
             numbers.iter( ).find( |m| m > n ).is_some( ) &&
             numbers.iter( ).find( |m| m < n ).is_some( ) 
             }).collect( ) ;
       println!("{}" , selected.len( ) ) ;
    }
}
