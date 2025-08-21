use std::io ;
use regex::Regex ;

fn parse_pair( bracket : &str ) -> (usize , usize) {
   let re = Regex::new( r"([0-9]+)").unwrap( ) ;
   let numbers : Vec<usize> = re.find_iter( bracket ).map( |m| {
         let found = m.as_str( ) ;
         let num : usize = found.parse::<usize>( ).unwrap( ) ;
         num
         }).collect( ) ;
   (numbers[0] , numbers[1])
}

fn main() {
    println!("Enter some tictactoe coordinates in brackets separated by ,!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let re = Regex::new( r"\[\s*([0-9]+)\s*\,\s*([0-9]+)\]").unwrap( ) ;
    let trimmed = inline.trim( ) ;
    let parts : Vec<&str> = re.find_iter(trimmed).map( |m| m.as_str( )).
    collect( ) ;
    let coordinates : Vec<(usize , usize)> = parts.into_iter( ).map( |s|
          parse_pair( s ) ).collect( ) ;
    let row : [char ; 3] = ['_' ; 3 ] ;
    let mut tictacboard : [[char ; 3] ; 3] = [row ; 3] ;
    let mut counter : usize = 0 ;
    for p in coordinates {
       if counter % 2 == 0 {
	  tictacboard[p.0][p.1] = 'A' ;
       }
       else {
	  tictacboard[p.0][p.1] = 'B' ;
       }
       counter += 1 ;
    }
    //test on row equality
    let rows_equal : bool = tictacboard.iter( ).any( |r| {
	  let head : char = r[0] ;
	  r.iter( ).all( |c| *c == head && *c != '_') 
	  }) ;
    let column_equal : bool = {
       let heads : [usize ; 3] = [0 , 1 , 2] ;
       heads.into_iter( ).any( |p| tictacboard[0][p] == tictacboard[1][p] && 
	     tictacboard[1][p] == tictacboard[2][p] && tictacboard[0][p] != '_') 
    } ;
    let left_down_diagonal : bool = tictacboard[0][0] == tictacboard[1][1] && 
       tictacboard[1][1] == tictacboard[2][2] && tictacboard[0][0] != '_' ;
    let right_up_diagonal : bool = tictacboard[2][0] == tictacboard[1][1] &&
       tictacboard[1][1] == tictacboard[0][2] && tictacboard[2][0] != '_' ;
    let is_drawn : bool = tictacboard.iter( ).all( |r| r.iter( ).all( |c| *c == 'A'
      || *c == 'B')) ;
    if rows_equal {
       let found = tictacboard.iter( ).position( |r| {
	     let head : char = r[0] ;
	     r.iter( ).all( |c| *c == head )
	     }) ;
       let pos = found.unwrap( ) ;
       println!("{}" , tictacboard[pos][0] ) ;
    }
    if column_equal {
       let heads = [0 , 1 , 2] ;
       let found = heads.into_iter( ).position( |n| tictacboard[0][n] == 
	     tictacboard[1][n] && tictacboard[1][n] == tictacboard[2][n] ) ;
       let pos : usize = found.unwrap( ) ;
       println!("{}" , tictacboard[0][pos] ) ;
    }
    if left_down_diagonal {
       println!("{}" , tictacboard[0][0] ) ;
    }
    if right_up_diagonal {
       println!("{}" , tictacboard[2][0] ) ;
    }
    if is_drawn {
       println!("Draw") ;
    }
    let possibilities : Vec<bool> = vec![rows_equal , column_equal ,
	left_down_diagonal , right_up_diagonal , is_drawn ] ;
    if possibilities.into_iter( ).all( |p| p == false ) {
       println!("Pending") ;
    }
}
