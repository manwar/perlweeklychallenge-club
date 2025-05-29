use std::io ;

fn main() {
    println!("Enter an income amount!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let income : u16 = inline.trim( ).parse::<u16>( ).unwrap( ) ;
    println!("Enter , separated by blanks and in brackets, tax rates!") ;
    println!("For example : [a,b] [c,d] and so on!" ) ;
    let mut taxrates : Vec<(u16,u16)> = Vec::new( ) ;
    let mut taxline : String = String::new( ) ;
    io::stdin( ).read_line( &mut taxline ).unwrap( ) ;
    let brackets : Vec<&str> = taxline.trim( ).split_whitespace( ).
       collect( ) ;
    for br in brackets {
       let commapos : usize = br.find( "," ).unwrap( ) ;
       let cur_string : String = br.into( ) ;
       let amount : u16 = cur_string[1..commapos].parse::<u16>( ).unwrap( ) ;
       let rate : u16 = cur_string[commapos + 1 .. cur_string.len( ) - 1 ].
	  parse::<u16>( ).unwrap( ) ;
       taxrates.push((amount , rate ) ) ;
    }
    let mut total_tax : f32 = 0.0 ;
    if income == 0 {
       println!("{}" , 0.0) ;
    }
    else {
       let mut taxparts : Vec<u16> = Vec::new( ) ;
       let mut differences : Vec<u16> = Vec::new( ) ;
       let len : usize = taxrates.len( ) ;
       differences.push( taxrates[0].0 ) ;
       for i in 1 .. len {
	  let diff : u16 = taxrates[i].0 - taxrates[i - 1].0 ;
	  differences.push( diff ) ;
       }
       let mut pos : usize = 0 ;
       while taxparts.iter( ).sum::<u16>( ) < income {
	  taxparts.push( differences[pos] ) ;
	  pos += 1 ;
       }
       let sum : u16 = taxparts.iter( ).sum( ) ;
       if sum > income {
	  let last : u16 = taxparts.remove( taxparts.len( ) - 1 ) ;
	  taxparts.push( last - (sum - income ) ) ;
       }
       for i in 0..taxparts.len( ) {
	  total_tax += taxparts[i] as f32 * ( taxrates[i].1 as 
		f32 / 100 as f32 )
       }
       println!("{}" , total_tax ) ;
    }
}
