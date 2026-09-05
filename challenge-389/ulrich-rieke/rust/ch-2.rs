use std::io ;

fn longest_undulating( numbers : &Vec<i32> ) -> usize {
   let len : usize = numbers.len( ) ;
   if numbers.iter( ).all( |n| *n == numbers[0] ) || len == 1  {
      1 
   }
   else {
      let mut sizes : Vec<usize> = Vec::new( ) ;
      let vecslice : &[i32] = numbers.as_slice( ) ;
      for start in 0..len - 1 {
         for end in start + 1 .. len + 1 {
            let current_slice : &[i32] = &vecslice[start..end] ;
            if is_undulating( &current_slice ) {
               sizes.push( current_slice.len( ) ) ;
            }
         }
      }
      sizes.into_iter( ).max( ).unwrap( ) 
   }
}

fn is_undulating( a_slice : &[i32] ) -> bool {
   let current : Vec<i32> = a_slice.to_vec( ) ;
   let len : usize = current.len( ) ;
   let value : bool = match len {
      0 => false , 
      1 => true , 
      2 => current[0] != current[1] , 
      _ => {
         let mut differences : Vec<i32> = Vec::new( ) ;
         for i in 1..len {
            differences.push( current[i] - current[i - 1] ) ;
         }
         let val : bool = (0..differences.len( ) - 1).all( |n| {
               (differences[n] < 0 && differences[n + 1] > 0 ) ||
               (differences[n] > 0 && differences[n + 1] < 0 ) 
               } ) ;
         val }
   } ;
   value
}

fn main() {
    println!("Enter some integer values!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( |s| 
         s.parse::<i32>( ).unwrap( ) ).collect( ) ;
    println!("{}" , longest_undulating( &numbers ) ) ;
}
