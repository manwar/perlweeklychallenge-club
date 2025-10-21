use std::io ;

fn main() {
    println!("Enter some number arrays , <return> to end!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let mut source : Vec<Vec<i32>> = Vec::new( ) ;
    while inline != "\n".to_string( ) {
       let nums : Vec<i32> = inline.trim( ).split_whitespace( ).map( 
	     |s| s.parse::<i32>().unwrap( )).collect( ) ;
       source.push( nums.clone( ) ) ;
       inline.clear( ) ;
       println!("Enter some number arrays , <return> to end!") ;
       io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    }
    println!("Enter a target array!") ;
    let mut targetline : String = String::new( ) ;
    io::stdin( ).read_line( &mut targetline ).unwrap( ) ;
    let target : Vec<i32> = targetline.trim( ).split_whitespace( ).
       map( |s| s.parse::<i32>().unwrap( )).collect( ) ;
    let mut source_elements : usize = 0 ;
    source.iter( ).map( |v| v.len( )).for_each( |d| source_elements += d ) ;
    if source_elements != target.len( ) {
       println!("false") ;
    }
    else {
       let condition : bool = source.into_iter( ).all( |v| {
	     let searched = &v[..] ;
	     let targetslice = &target[..] ;
	     let neighbours : Vec<&[i32]> = targetslice.windows( v.len( ) )
	      .collect( ) ;
	     neighbours.iter( ).find( |&&n| n == searched ).is_some( )
	     }) ;
       println!("{}" , condition ) ;
    }
}
