use std::io ;

fn main() {
    println!("Enter an even number of positive integers!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<u32> = inline.trim( ).split_whitespace( ).map( |s|
          s.parse::<u32>().unwrap( ) ).collect( ) ;
    let numberslice : &[u32] = &numbers[..] ;
    let mut neighbours : Vec<_> = numberslice.chunks( 2 ).collect( ) ;
    neighbours.sort_by_key( |v| v[0] ) ;
    let mut sorted_neighbours : Vec<_> = Vec::new( ) ;
    sorted_neighbours.push( neighbours[0] ) ;
    for i in 1..neighbours.len( ) {
       let l = sorted_neighbours.len( ) ;
       if neighbours[i][0] > sorted_neighbours[l - 1][0] &&
          neighbours[i][1] > sorted_neighbours[l - 1][1] {
             sorted_neighbours.push( neighbours[i] ) ;
          }
    }
    println!("{}" , sorted_neighbours.len( ) ) ;
}
