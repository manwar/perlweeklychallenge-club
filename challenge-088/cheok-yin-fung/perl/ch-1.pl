perl -e 'for $j (0..scalar @ARGV-1) {$a = 1; eval {$a *= $ARGV[$_] if $_ != $j} for (0..scalar @ARGV-1); print "$a "; }' 5 2 1 4 3


# $ perl -e 'for $j (0..scalar @ARGV-1) {$a = 1; eval {$a *= $ARGV[$i] if $i != $j} for $i (0..scalar @ARGV-1); print "$a "; }' 5 2 1 4 3
# Differing the one-line solution by an explicit index for iteration, 
# the above line gets error; the error message is: 
# syntax error at -e line 1, near "$i (" 
# Execution of -e aborted due to compilation errors.
