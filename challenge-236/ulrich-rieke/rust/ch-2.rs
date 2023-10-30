use std::io ;
use std::collections::HashSet ;

fn main() {
    println!("Enter some unique positive integers!");
    println!("They should be a random shuffle of integers from 0 to array length!") ;
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<usize> = entered_line.split_whitespace( ).map( | s | 
	  s.trim( ).parse::<usize>( ).unwrap( ) ).collect( ) ;
    let mut loops : usize = 0 ;
    //the strategy is as follows : if a number in the array represents its own 
    //index, it is a loop in itself , and the number of loops can be increased
    //otherwise: for every index in the vector, we build a set of numbers we fill
    //by adding numbers from numbers[current_index]. If we cannot add a number 
    //to the set because it is already there no loop can be formed at that index.
    //Otherwise we continue until, eventually, numbers[current_index] == start_index
    for pos in 0..numbers.len( ) {
       if numbers[ pos ] == pos {
	  loops += 1 ;
       }
       else {
	  let mut already_seen : HashSet<usize> = HashSet::new( ) ;
	  let mut num : usize = numbers[ pos ] ; 
	  let mut inserted : bool = already_seen.insert( num ) ;
	  'inner: while inserted {
	     println!("{:?}" , already_seen ) ;
	     if already_seen.contains( &pos ) {
		loops += 1 ;
		break 'inner ;
	     }
	     else {
		num = numbers[ num ] ;
		inserted = already_seen.insert( num ) ;
	     }
	  }
       }
    }
    println!("{}" , loops) ;
}

