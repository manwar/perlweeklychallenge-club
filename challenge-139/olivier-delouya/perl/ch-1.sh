perl -se "@N=eval($N); $I=scalar(@N)-1; for($i=0; $i<$I; $i++) { exit(print 0) if($N[$i] > $N[$i+1]);} print 1;" -- -N="(1,2,3,4,5)"

perl -se "@N=eval($N); $I=scalar(@N)-1; for($i=0; $i<$I; $i++) { exit(print 0) if($N[$i] > $N[$i+1]);} print 1;" -- -N="(1,3,2,4,5)"
