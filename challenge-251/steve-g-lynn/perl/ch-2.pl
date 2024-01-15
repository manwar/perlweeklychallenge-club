#perl 4.019 on DOSBOX

sub matrix {
 local ($nrow, $ncol, @data)=@_;
 (scalar(@data)==$nrow*$ncol) || die "Matrix data input error: $!\n";

 local (%matrix,$y,$x);
 foreach $y (0 .. $nrow-1){
  foreach $x (0 .. $ncol-1){
    $matrix{ "$y,$x" } = shift(@data);
  }
 }
 %matrix;
}

sub column {
 local ($colno, %matrix)=@_;
 local (@column) = @matrix { grep( $_ =~ /,$colno/, keys %matrix) };
 @column;
}

sub row {
 local ($rowno, %matrix)=@_;
 local (@row) = @matrix { grep( $_ =~ /^$rowno,/, keys %matrix) };
 @row;
}

sub lucky_numbers {
 local ($nrow, $ncol)=($_[0], $_[1]);
 local (%matrix)=&matrix(@_);
 local ($y, $x,$retval);
 $retval=-1;
 OUTER: foreach $y (0 .. $nrow-1) {
  INNER: foreach $x (0 .. $ncol-1) {
   local ($rowmin)=((sort {$a<=>$b;} &row($y, %matrix))[0]);
   local ($colmax)=((sort {$b<=>$a;} &column($x, %matrix))[0]);
   if (($matrix{"$y,$x"}==$rowmin) && ($matrix{"$y,$x"}==$colmax)) {
    $retval = $matrix{"$y,$x"};
    last OUTER;
   } #if 
  } #INNER
 } #OUTER
 $retval;
}

print &lucky_numbers(3,3,3,7,8,9,11,13,15,16,17),"\n"; #15
print &lucky_numbers(3,4,1,10,4,2,9,3,8,7,15,16,17,12),"\n"; #12
print &lucky_numbers(2,2,7,8,1,2),"\n"; #7
