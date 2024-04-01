# Perl 4.019 on DOSBOX

sub smaller_than_current {
 local(@ints)=@_;
 local(@ranks)=(sort {$ints[$a]<=>$ints[$b];} 0..$#ints);
 local($i,@retval);
 
 $retval[$ranks[0]]=0;
 foreach $i (1 .. $#ranks){
  if ($ints[$ranks[$i]]==$ints[$ranks[$i-1]]) {
   $retval[$ranks[$i]]=$retval[$ranks[$i-1]];
  }
  else {
   $retval[$ranks[$i]]=$i;
  }
 }
 @retval;
}

sub arr_print {
 print "@_\n";
}

&arr_print( &smaller_than_current(5,2,1,6) ); # 2 1 0 3
&arr_print( &smaller_than_current(1,2,0,3) ); # 1 2 0 3
&arr_print( &smaller_than_current(0,1) ); # 0 1 
&arr_print( &smaller_than_current(9,4,9,2) ); # 2 1 2 0
