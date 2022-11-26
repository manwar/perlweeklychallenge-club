use std::io ;

fn main() {
  let mut inline : String = String::new( ) ;
  println!("Please enter some integers, separated by blanks!") ;
  io::stdin( ).read_line( &mut inline ).unwrap( ) ;
  let entered_line : &str = &*inline ;
  let mut numbers : Vec<i32> = entered_line.split_whitespace( )
      .map( | s | s.trim( ).parse::<i32>().unwrap( )).collect( ) ;
  if numbers.iter( ).sum::<i32>( ) % (numbers.len( ) as i32 ) != 0 {
      println!("-1") ;
  }
  //find the maximum number, add 1 to the smaller of the 2 neighbours,
  //, subtract 1 from the maximum! if there is only one neighbour increment
  //it! If there are 2 equal neighbours, look for the minimum and increment
  //the neighbour at the "minimum side" to avoid possible endless loops!
  else {
      if numbers.iter( ).all( | s | *s == numbers[ 0 ] ) {
    println!("0") ;
      }
      else {
    let mut count : i32 = 0 ;
    while ! numbers.iter( ).all( | i | *i == numbers[0] ) {
        let maximum : i32 = *numbers.iter( ).max( ).unwrap( ) ;
        let max_index : usize = numbers.iter( ).position( | &i | i ==
          maximum ).unwrap( ) ;
        numbers[max_index] -= 1 ;
        match max_index {
          0 => { numbers[ 1 ] += 1 } ,
          the_position if the_position == numbers.len( ) - 1  =>
            { numbers[ the_position - 1 ] += 1 } ,
          _ => {
          match numbers[ max_index - 1 ] - numbers[max_index + 1] {
            difference if difference < 0 => { numbers[ max_index - 1 ]
            += 1 } ,
            difference if difference > 0 => { numbers[ max_index + 1 ]
            += 1 } ,
            _ => {
            let minimum : i32 = *numbers.iter( ).min( ).unwrap( ) ;
            let min_index : usize = numbers.iter( ).position( | &i |
                  i == minimum ).unwrap( ) ;
            if min_index > max_index {
              numbers[ max_index + 1 ] += 1 ;
            }
            else {
              numbers[ max_index - 1 ] += 1 ;
            }
            }
          }
          }
        } ;
        count += 1 ;
    }
    println!("{}" , count ) ;
      }
  }
}
