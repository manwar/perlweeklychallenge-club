use v5.36;
##
# You are given a sorted unique integer array, @array.
# Write a script to find all possible Number Range (i.e [x, y]) 
# represent range all integers from x and y (both inclusive).
##
use Data::Dump q/pp/;
sub range_list{
    my @numbers = @_;
    my %ranges;
    my @ranges; 
    for my $i (0 .. @numbers - 2){
	if($numbers[$i] == $numbers[$i + 1] - 1){ 
            $ranges{$numbers[$i]} = undef;
	    $ranges{$numbers[$i + 1]} = undef;
        }
	if((keys %ranges) > 0 && $numbers[$i] != $numbers[$i + 1] - 1){ 
	    push @ranges, [sort {$a <=> $b} keys %ranges];
            %ranges = (); 
        }
    }
    if((keys %ranges) > 0){ 
        push @ranges, [sort {$a <=> $b} keys %ranges];
    }
    @ranges = map { [$_->[0], $_->[@{$_} - 1]] } @ranges;  
    return @ranges;    
}

MAIN:{
    say pp range_list(1, 3, 4, 5, 7);  
    say pp range_list(1, 2, 3, 6, 7, 9);  
    say pp range_list(0, 1, 2, 4, 5, 6, 8, 9);  
}
