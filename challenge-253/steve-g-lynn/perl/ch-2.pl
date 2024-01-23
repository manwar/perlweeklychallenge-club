#perl 4.019 on DOSBOX

sub mysum {
 local(@mysum)=split(//,$_[0]);
 local($mysum)=0;
 foreach (@mysum){
  $mysum += $_;
 }
 $mysum;
}

sub weakest_row {
 #input valuation
 local($weakest_row) = length($_[0]);
 foreach (@_) {
  ($_ =~ /^[01]+$/) || (die "Input error: $!\n");
  (length($_) == $weakest_row) || (die "Not a matrix: $!\n");
 }
    
 sort { (&mysum($_[$a]) <=> &mysum($_[$b])) ||
     ($a <=> $b);
 } 0 .. $#_;
}

print join( ",", &weakest_row('11000','11110','10000','11000','11111') ),"\n";
print join( ",", &weakest_row('1000','1111','1000','1000') ), "\n";
