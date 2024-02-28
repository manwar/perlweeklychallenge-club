#perl 4.019 on DOSBOX

#get binary number using vec(.).
#only works for indexes up to 9
#

print &sum_of_values(1,2,5,9,11,3),"\n"; #17
print &sum_of_values(2,2,5,9,11,3),"\n"; #11
print &sum_of_values(0,2,5,9,11,3),"\n"; #2

sub sum_of_values {
 local($k,@ints)=@_;
 ($#ints > 9) && (return "Error. Max 10 elements allowed.");
 grep($_ =~ /[^0-9]/, ($k,@ints)) && (return "Error. Only integers allowed.");
 local($sum_of_values)=0;
 foreach (0 .. $#ints) {
  (&binsum($_)==$k) && ($sum_of_values += $ints[$_]);
 }
 $sum_of_values;
}


sub binsum {
 #sum of digits of binary form of a number
 local($num)=$_[0];
 local($binsum)=0;
 foreach (0 .. 3) {
  $binsum += vec($num,$_,1);
 }
 $binsum;
}


