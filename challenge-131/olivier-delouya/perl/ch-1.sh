perl -se "@N=eval($N); $_prev=$N[0]-1; print '(['; foreach(@N) {if($_ != $_prev+1) {print \"\b],[\"}; print \"$_,\"; $_prev=$_;}; print \"\b])\" " -- -N="(1, 2, 3, 6, 7, 8, 9)"

perl -se "@N=eval($N); $_prev=$N[0]-1; print '(['; foreach(@N) {if($_ != $_prev+1) {print \"\b],[\"}; print \"$_,\"; $_prev=$_;}; print \"\b])\" " -- -N="(11, 12, 14, 17, 18, 19)"

perl -se "@N=eval($N); $_prev=$N[0]-1; print '(['; foreach(@N) {if($_ != $_prev+1) {print \"\b],[\"}; print \"$_,\"; $_prev=$_;}; print \"\b])\" " -- -N="(2, 4, 6, 8)"

perl -se "@N=eval($N); $_prev=$N[0]-1; print '(['; foreach(@N) {if($_ != $_prev+1) {print \"\b],[\"}; print \"$_,\"; $_prev=$_;}; print \"\b])\" " -- -N="(1, 2, 3, 4, 5)"
