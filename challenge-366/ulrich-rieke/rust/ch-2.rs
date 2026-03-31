fn find_possibilities( timeterm : &str ) -> u16 {
   let mut possibilities : u16 = 1 ;
   if timeterm.starts_with( "??" ) {
      possibilities *= 24 ;
   }
   else {
      let first_let : char = timeterm.chars( ).nth(0).unwrap( ) ;
      let second_let : char = timeterm.chars( ).nth(1).unwrap( ) ;
      if first_let == '?' {
         let num : u32 = second_let.to_digit( 10 ).unwrap( ) ;
         if num < 4 {
            possibilities *= 3 ;
         }
         else {
            possibilities *= 2 ;
         }
      }
      if second_let == '?' {
         let num : u32 = first_let.to_digit( 10 ).unwrap( ) ;
         if num < 2 {
            possibilities *= 10 ;
         }
         else {
            possibilities *= 4 ;
         }
      }
   }
   if timeterm.chars( ).nth( 3 ).unwrap( ) == '?' {
      possibilities *= 6 ;
   }
   if timeterm.chars( ).nth( 4 ).unwrap( ) == '?' {
      possibilities *= 10 ;
   }
   possibilities
}

fn main() {
    println!("{}" , find_possibilities( "?2:34" )) ;
    println!("{}" , find_possibilities( "?4:?0" )) ;
    println!("{}" , find_possibilities( "??:??" ));
    println!("{}" , find_possibilities( "?3:45" ) ) ;
    println!("{}" , find_possibilities( "2?:15" )) ;
}
