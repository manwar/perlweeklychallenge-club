perl -se "@N=eval($N); @P=eval($P); $hash{$_}=undef foreach(@N); foreach(@P) {if(exists $hash{$_}) {print 0; exit; }} print 1; " -- -N="(1, 2, 5, 3, 4)" -P="(4, 6, 7, 8, 9)"

perl -se "@N=eval($N); @P=eval($P); $hash{$_}=undef foreach(@N); foreach(@P) {if(exists $hash{$_}) {print 0; exit; }} print 1; " -- -N="(1, 3, 5, 7, 9)" -P="(0, 2, 4, 6, 8)"
