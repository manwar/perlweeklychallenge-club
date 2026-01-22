fn simplify( numerator : u16 , denominator : u16 ) -> (u16 , u16) {
   use std::collections::HashSet ;
   let mut first_divisors : HashSet<_> = HashSet::new( ) ;
   let mut second_divisors : HashSet<_> = HashSet::new( ) ;
   for n in 1..=numerator {
      if numerator % n == 0 {
         first_divisors.insert( n ) ;
      }
   }
   for n in 1..=denominator {
      if denominator % n == 0 {
         second_divisors.insert( n ) ;
      }
   }
   let common_divisors : Vec<&u16> = first_divisors.intersection( &
         second_divisors ).collect( ) ;
   if common_divisors.len( ) > 0 {
      let max_div : u16 = *common_divisors.into_iter( ).max( ).unwrap( ) ;
      (numerator / max_div , denominator / max_div )
   }
   else {
      (numerator , denominator )
   }
}

fn main() {
    use std::io ;
    println!("Enter a positive integer!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let number : u16 = inline.trim_end( ).parse::<u16>( ).unwrap( ) ;
    let mut fractions : Vec<(f32 , (u16 , u16))> = Vec::new( ) ;
    for num in 1..=number {
       for denom in 1..=number {
          fractions.push( ((num as f32) / ( denom as f32 ) , ( num , 
                   denom ))) ;
       }
    }
    fractions.sort_by( |a , b| a.0.partial_cmp( &b.0 ).unwrap( ) ) ;
    fractions.dedup( ) ;
    let mut result : Vec<String> = fractions.into_iter( ).map( |p| {
          let tuple = simplify( p.1.0 , p.1.1 ) ;
          let numstring : String = tuple.0.to_string( ) ;
          let denomstring : String = tuple.1.to_string( ) ;
          let outputstr : String = numstring.clone( ) + "/" + &denomstring ;
          outputstr
          } ).collect( ) ;
    result.dedup( ) ;
    println!("{:?}" , result ) ;
}
