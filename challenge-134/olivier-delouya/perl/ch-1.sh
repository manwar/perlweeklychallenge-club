perl -e "foreach my $j (2..6) { foreach my $i (1..10) { print (($i < $j)? $i : (($i == $j)? 0:$i-1)); } print \"\n\"; }"
