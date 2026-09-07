use std::io ;

fn find_positions( input : &String ) -> Vec<usize> {
   let mut positions : Vec<usize> = Vec::new( ) ;
   let comparison : String = "01".into( ) ;
   for i in 0usize..input.len( ) - 1 {
      let partial : String = input[i..i + 2].to_string( ) ;
      if partial == comparison {
         positions.push( i ) ;
      }
   }
   let mut result : Vec<usize> = Vec::new( ) ;
   if positions.len( ) > 0 {
      result.push( positions[0] ) ;
      for i in 1usize..positions.len( ) {
         if positions[i] >= result[result.len( ) - 1] + 2 {
            result.push( positions[i] ) ;
         }
      }
   }
   result 
}

fn main() {
    println!("Enter a binary string!");
    let mut binary : String = String::new( ) ;
    io::stdin().read_line( &mut binary ).unwrap( ) ;
    let mut changed : String = binary.trim( ).into( ) ;
    let mut steps : usize = 0 ;
    let mut positions : Vec<usize> = find_positions( &changed ) ;
    while positions.len( ) > 0 {
       positions.iter( ).map( |i| i ).for_each( |i| {
             changed.replace_range(*i..*i + 2 , "10" ) ;
             }) ;
       steps += 1 ;
       positions = find_positions( &changed ) ;
    }
    println!("{}" , steps ) ;
}
