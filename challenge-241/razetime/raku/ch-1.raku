sub ch1(@n,$d) {
  my $c=0;
	for 0..^@n.elems -> $i {
		for ($i+1)..^@n.elems -> $j {
			for ($j+1)..^@n.elems -> $k {
        if (@n[$j] - @n[$i] == $d && @n[$k] - @n[$j] == $d) {
          $c+=1;
        }
      }
    }
  }
  return $c;
}

say ch1((0,1,4,6,7,10),3); 
say ch1((4,5,6,7,8,9),2); 
