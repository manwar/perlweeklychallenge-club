use strict;
use warnings;
##
# You are given a sorted array of distinct integers @N and a target $N.
# Write a script to return the index of the given target if found otherwise 
# place the target in the sorted array and return the index.
##
sub find_insert{
    my($list, $n) = @_;
    if($n < $list->[0]){
        unshift @{$list}, $n;
        return 0;
    }
    if($n > $list->[@{$list} - 1]){
        push @{$list}, $n;
        return @{$list} - 1;
    }
    for(my $i = 0; $i < (@{$list} - 1); $i++){
        return $i if $n == $list->[$i];
        if($n > $list->[$i] && $n < $list->[$i + 1]){
            splice(@{$list}, $i, 2, ($list->[$i], $n, $list->[$i + 1]));
            return $i + 1;
        }
    }
}


MAIN:{
    my(@N, $N, $i);
    @N = (1, 2, 3, 4);
    $N = 3;
    $i = find_insert(\@N, $N);
    print "$i\n"; 
    
    @N = (1, 3, 5, 7);
    $N = 6;
    $i = find_insert(\@N, $N);
    print "$i\n"; 
    
    @N = (12, 14, 16, 18);
    $N = 10;
    $i = find_insert(\@N, $N);
    print "$i\n"; 
    
    @N = (11, 13, 15, 17);
    $N = 19;
    $i = find_insert(\@N, $N);
    print "$i\n"; 
}

