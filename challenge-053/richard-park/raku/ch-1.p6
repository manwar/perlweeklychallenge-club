use v6;
sub Transpose( @matrix = [[1,2,3],[4,5,6],[7,8,9]] ) {  
  my @newmat;
  loop (my $i = 0;$i < @matrix.elems;$i++) {
    loop (my $j = 0;$j < @matrix[$i].elems;$j++) {
	  @newmat[$i][$j] = @matrix[$j][$i];	  
	}
  }
  @newmat;
}

sub Rotate( $angle, @matrix = [[1,2,3],[4,5,6],[7,8,9]] ) {  
  # Rotate matrix clockwise by $angle degrees
  my $times = $angle/90;  
  for 1..$times {    
    @matrix = Transpose(Reflect(@matrix));
  }
  @matrix;  
}	

sub Reflect( @matrix = [[1,2,3],[4,5,6],[7,8,9]] ) {
  # Reflect matrix in leading axis (vertical flip)
  my @newmat;
  loop (my $j = 0;$j < @matrix.elems;$j++) {
    loop (my $k = 0;$k < @matrix[$j].elems;$k++) {	   	
	  @newmat[$j][$k] = @matrix[@matrix.elems - ($j + 1)][$k];	  
    }	  	  
  }
  @newmat;
}

say 'Hello';
say Transpose();
say Reflect();
my @mat = [['a','b','c'],['d','e','f'],['g','h','i']];
say Rotate(270, @mat);
