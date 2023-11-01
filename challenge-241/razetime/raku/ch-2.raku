sub ch2(@a) {return @a.sort({
  my @p=(2..*).grep({.is-prime});
  my $i=0;
  my $r=0;
  my $s=$_;
  while $s>1 {
    if $s%%@p[$i] {
			$s=$s div @p[$i];
      $r+=1;
    } else { $i+=1;}
  }
  $r; 
});}

say ch2((11,8,27,4));
