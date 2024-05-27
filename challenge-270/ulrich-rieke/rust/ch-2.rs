use std::io ;

fn find_best_combi( combinations : Vec<Vec<i32>> , x : i32 , y : i32 ) ->
 i32 {
    let mut costs : Vec<i32> = Vec::new( ) ;
    for combi in combinations {
       let ones = combi.iter( ).filter( | &d | *d == 1 ).count( ) ;
       let twos = combi.iter( ).filter( | &d | *d == 2 ).count( ) ;
       let cost : i32 = ones as i32 * x + twos as i32 * y ;
       costs.push( cost ) ;
    }
    costs.into_iter( ).min( ).unwrap( ) 
 }

fn find_combinations( a_sum : i32 ) -> Vec<Vec<i32>> {
   let mut all_combis : Vec<Vec<i32>> = Vec::new( ) ;
   for d in 0..=a_sum / 2 {
      let mut single_combi : Vec<i32> = Vec::new( ) ;
      let ones = a_sum - d * 2 ;
      for _ in 0..ones {
	 single_combi.push( 1 ) ;
      }
      for _ in 0..d {
	 single_combi.push( 2 ) ;
      }
      all_combis.push( single_combi ) ;
   }
   all_combis 
}

fn main() {
    println!("Enter some integers, separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let entered_line : &str = &*inline ;
    let numbers : Vec<i32> = entered_line.trim( ).split_whitespace( ).map( 
	  | s | s.parse::<i32>( ).unwrap( ) ).collect( ) ;
    println!("Enter an integer x and an integer y , meaning the costs!") ;
    inline.clear( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let xline : &str = &*inline ;
    let costs : Vec<i32> = xline.trim( ).split_whitespace( ).map( | s | 
	  s.parse::<i32>( ).unwrap( ) ).collect( ) ;
    let x : i32 = costs[0] ;
    let y : i32 = costs[ 1 ] ;
    //find all ways to add 1 and 2 so that the sum of the differences of all
    //numbers smaller than the maximum number is equalled!
    if numbers.len( ) == 1 || numbers.iter( ).all( | i | *i == numbers[0] ) {
       println!("0") ;
    }
    else {
       let max : i32 = *numbers.iter( ).max( ).unwrap( ) ;
       let smaller : Vec<i32> = numbers.into_iter( ).filter( | &d | d < max ).
	  collect( ) ;
       let total_diff : i32 = smaller.iter( ).map( | i | max - *i ).sum( ) ;
       if smaller.len( ) == 1 {
	  println!("{}" , total_diff * x ) ;
       }
       else {
	  let combinations : Vec<Vec<i32>> = find_combinations( total_diff ) ;
	  let result : i32 = find_best_combi( combinations , x , y ) ;
	  println!("{}" , result ) ;
       }
    }
}
