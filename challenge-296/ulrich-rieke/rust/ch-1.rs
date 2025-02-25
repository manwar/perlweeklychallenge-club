use std::io ;

fn compress( word : &str ) -> String {
   let mut char_blocks : Vec<Vec<char>> = Vec::new( ) ;
   let mut compressed : String = String::new( ) ;
   let mut grouped : Vec<char> = Vec::new( ) ;
   let mut last_char : char = word.chars( ).nth( 0 ).unwrap( ) ;
   grouped.push( last_char ) ;
   let len = word.chars( ).count( ) ;
   for i in 1..len {
      let next_char : char = word.chars( ).nth( i ).unwrap( ) ;
      if next_char == last_char {
	 grouped.push( next_char ) ;
      }
      else {
	 char_blocks.push( grouped.clone( ) ) ;
	 grouped.clear( ) ;
	 grouped.push( next_char ) ;
	 last_char = next_char ;
      }
   }
   if grouped.len( ) > 0 {
      char_blocks.push( grouped.clone( ) ) ;
      grouped.clear( ) ;
   }
   char_blocks.into_iter( ).map( |v| {
	 let mut comp : String = String::new( ) ;
	 let l = v.len( ) ;
	 if l > 1 {
	    let c = char::from_digit( l as u32 , 10 ).unwrap( ) ;
	    let b = v[0] ;
	    comp.push( c ) ;
	    comp.push( b ) ;
	 }
	 else {
	    comp.push( v[0] ) ;
	 }
	 comp } ).for_each( |st| compressed.push_str( &st ) ) ;
   compressed 
}

fn decompress( word : &str ) -> String {
   let mut decompressed : String = String::new( ) ;
   let mut pos : usize = 0 ;
   let len = word.chars( ).count( ) ;
   while pos != len {
      let c = word.chars( ).nth( pos ).unwrap( ) ;
      if c.is_ascii_digit( ) {
	 let num = c.to_digit( 10 ).unwrap( ) ;
	 pos += 1 ;
	 let c = word.chars( ).nth( pos ).unwrap( ) ;
	 for _ in 0..num {
	    decompressed.push( c ) ;
	 }
      }
      else {
	 decompressed.push( c ) ;
      }
      pos += 1 ;
   }
   decompressed 
}

fn main() {
    println!("Enter a word!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let trimmed = inline.trim( ) ;
    let compressed : String = compress( &trimmed ) ;
    println!("{:?} becomes {:?}" , trimmed , compressed ) ;
    let decompressed : String = decompress( &compressed ) ;
    println!("decompressed again: {:?} " , decompressed ) ;
}
