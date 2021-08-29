perl -se "$S=0; for($i=2; $i<=$N; $i++) {$S++ if($i !~ /1/)}; print \"$S\n\";" -- -N=15
