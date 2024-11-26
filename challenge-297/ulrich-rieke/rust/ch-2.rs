use std::io ;

fn main() {
    println!("Enter a numbers of integers, with each of them occurring only once!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s| 
	  s.parse::<i32>( ).unwrap( ) ).collect( ) ;
    let len : usize = numbers.len( ) ;
    let mini : i32 = *numbers.iter( ).min( ).unwrap( ) ;
    let maxi : i32 = *numbers.iter( ).max( ).unwrap( ) ;
    let minpos : usize = numbers.iter( ).position( |d| *d == mini ).unwrap( ) ;
    let maxpos : usize = numbers.iter( ).position( |d| *d == maxi ).unwrap( ) ;
    if minpos < maxpos {
       println!("{}" , minpos + len - 1 - maxpos ) ;
    }
    else { //one less than abovo because the minimum and the maximum move
       //past each other
       println!("{}" , minpos + len - 1 - maxpos - 1) ;
    }
}
