use std::io ;
use std::collections::HashSet ;

fn main() {
    println!("Enter some  numbers, separated by blanks!");
    println!("The length of the number array should be even!" ) ;
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let mut numbers : Vec<f32> = inline.trim( ).split_whitespace( ).map( |s|
	  s.parse::<f32>().unwrap( ) ).collect( ) ;
    //in order to collect all the f32 averages in a HashSet one has
    //to convert every f32 average into a string since f32 doesn't fulfil
    //the necessary traits!
    let mut averages : HashSet<String> = HashSet::new( ) ;
    numbers.sort_by(|a , b| a.partial_cmp(b).unwrap( ) ) ;
    let len : usize = numbers.len( ) ;
    for i in 0..len / 2 {
       let average : f32 = ( numbers[i] + numbers[ len - i - 1] ) / 2.0 ;
       let aver_str = average.to_string( ) ;
       averages.insert( aver_str ) ;
    }
    println!("{}" , averages.len( ) ) ;
}
