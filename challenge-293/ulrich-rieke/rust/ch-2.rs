use std::io ;

#[derive( Copy , Clone , PartialEq )]
struct Point {
   x : i32 , 
   y : i32 ,
}

impl Point {
   fn new(my_x : i32 , my_y : i32) -> Point {
      Point{ x : my_x , y : my_y } 
   }
}

fn find_slope( p1 : Point , p2 : Point ) -> f32 {
   ((p2.y - p1.y) as f32) / ((p2.x - p1.x) as f32)
}

fn main() {
    let mut points : Vec<Point> = Vec::new( ) ;
    for _ in 0..3 {
       println!("Enter the coordinates of a point as integers!") ;
       let mut inline : String = String::new( ) ;
       io::stdin( ).read_line( &mut inline ).unwrap( ) ;
       let numbers : Vec<i32> = inline.trim( ).split_whitespace( ).map( 
	     |s| s.parse::<i32>( ).unwrap( ) ).collect( ) ;
       let p : Point = Point::new( numbers[0] , numbers[1] ) ;
       points.push( p ) ;
    }
    let first_condition : bool = points[0] != points[1] && points[1] != 
       points[2] ;
    let second_condition : bool = find_slope( points[0] , points[1] ) != 
       find_slope( points[1] , points[2] ) ;
    println!("{}" , first_condition && second_condition ) ;
}
