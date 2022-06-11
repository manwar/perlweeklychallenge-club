equilibrium='@A=eval($a); $N=scalar(@A); die "Not enough element" if($N < 3); foreach my $i (1..$N-1) { $left=$right=0; map {$left += $_} @A[0..$i-1]; map {$right += $_} @A[$i+1..$N]; die "equilibrium index is $i" if($left == $right); }; print "no equilibrium index"; '

perl -se "$equilibrium" -- -a="(1,2,3,2,1)"

perl -se "$equilibrium" -- -a="(1,2,3,2,10)"

perl -se "$equilibrium" -- -a="(1,2,7,9,10)"

perl -se "$equilibrium" -- -a="(1,2)"
