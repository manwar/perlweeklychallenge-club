use std::io ;

fn make_chessboard( ) -> Vec<String> {
   let mut chessboard : Vec<String> = Vec::new( ) ;
   let mut row : String = String::new( ) ;
   for i in 1..9 {
      if i % 2 == 1 {
         for _ in 0..4 {
            row.push_str( "BW" ) ;
         }
      }
      else {
         for _ in 0..4 {
            row.push_str( "WB" ) ;
         }
      }
      chessboard.push( row.clone( ) ) ;
      row.clear( ) ;
   }
   chessboard
}

fn main() {
    println!("Enter two chess fields separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let fields : Vec<&str> = inline.trim( ).split_whitespace( ).collect( ) ;
    let firstcol : char = fields[0].chars( ).nth( 0 ).unwrap( ) ;
    let firstrow : char = fields[0].chars( ).nth( 1 ).unwrap( ) ;
    let secondcol : char = fields[1].chars( ).nth( 0 ).unwrap( ) ;
    let secondrow : char = fields[1].chars( ).nth( 1 ).unwrap( ) ;
    let chessboard : Vec<String> = make_chessboard( ) ;
    let fr : usize = firstrow.to_digit( 10 ).unwrap( ) as usize - 1 ;
    let sr : usize = secondrow.to_digit( 10 ).unwrap( ) as usize - 1 ;
    let fc : usize = "abcdefgh".find( firstcol ).unwrap( ) ;
    let sc : usize = "abcdefgh".find( secondcol ).unwrap( ) ;
    println!("{}" , chessboard[fr][fc..fc + 1] == chessboard[sr][sc..sc + 1] ) ;
}
