use std::io ;
use itertools::Itertools ;

fn main() {
    println!("Enter some integer numbers separated by blanks!");
    let mut inline : String = String::new( ) ;
    io::stdin( ).read_line( &mut inline ).unwrap( ) ;
    let numbered_elems : Vec<(usize, i32)> = inline.trim( ).
       split_whitespace( ).map( |s| s.parse::<i32>( ).unwrap( )).
             enumerate( ).map( |p| {
             let augmented : usize = p.0 + 1 ;
             (augmented , p.1 )
             }).collect( ) ;
    //for every element in numbered_elems , check whether the element equals
    //the index number . Then do the same for the sum of all elements and for
    //the sum of all subvectors of the combination of 2 up to the number of
    //elements - 1 
    //from the examples , I understand that neither one single element is
    //regarded as a subset nor the whole sequence of numbers
    let mut all_subvectors : Vec<Vec<(usize , i32)>> = Vec::new( ) ;
    let len : usize = numbered_elems.len( ) ;
    for i in 2..len {
       let combis = numbered_elems.iter( ).combinations(i) ;
       for combi in combis {
          let newcombi : Vec<(usize, i32)> = combi.into_iter( ).map( |el| {
                let newelement : ( usize , i32 ) = (el.0 , el.1 ) ;
                newelement 
                }).collect( ) ;
          all_subvectors.push( newcombi.clone( ) ) ;
       }
    }
    let result : Vec<Vec<(usize , i32)>> = all_subvectors.into_iter( ).filter( |el :
          &Vec<(usize , i32)>| {
          let indices : Vec<usize> = el.iter( ).map( |p| p.0 ).collect( ) ;
          let elements : Vec<i32> = el.iter( ).map( |p| p.1 ).collect( ) ;
          let indexsum : usize = indices.iter( ).sum( ) ;
          let elementsum : i32 = elements.iter( ).sum( ) ;
          elementsum > 0 && indexsum as i32 == elementsum 
          } ).collect( ) ;
    let output : Vec<Vec<i32>> = result.into_iter( ).map( |v| {
          let nums : Vec<i32> = v.iter( ).map( |p| p.1 ).collect( ) ;
          nums 
          }).collect( ) ;
    println!("{:?}" , output ) ;
}
