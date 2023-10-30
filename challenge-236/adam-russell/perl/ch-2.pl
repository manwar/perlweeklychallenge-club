use v5.36;
##
# You are given an array of unique integers.
# Write a script to determine how many loops are in the given array.
# To determine a loop: Start at an index and take the number at array[index] and then 
# proceed to that index and continue this until you end up at the starting index.
##
use boolean;
sub loop_counter{
    my @integers = @_;
    my @loops;
    do{
        my @loop;
        my $loop_found = false;
        my $start = $_;
        my $next = $integers[$start];
        push @loop, $start, $next;
        my $counter = 1;
        {
			if($next == $start){
			    shift @loop;
				if(@loops == 0 || @loop == 2){
					push @loops, \@loop;
					my @loop;
					$loop_found = true;
				}
				else{
				    my $loop_duplicate = false;
				    my @s0 = sort @loop;
				    do { 
						my @s1 = sort @{$_}; 						
						$loop_duplicate = true if((@s0 == @s1) && (0 < grep {$s0[$_] == $s1[$_]} 0 .. @s0 - 1));
					} for @loops;	
					if(!$loop_duplicate){
					    $loop_found = true;
					    push @loops, \@loop;
					}
					else{
					    $counter = @integers + 1; 
					}			
				}
			}
			else{
				$next = $integers[$next];
				push @loop, $next;   
				$counter++;     
			}
			redo unless $loop_found || $counter > @integers;
        }
    } for 0 .. @integers - 1; 
    return @loops + 0;
}

MAIN:{
    say loop_counter 4, 6, 3, 8, 15, 0, 13, 18, 7, 16, 14, 19, 17, 5, 11, 1, 12, 2, 9, 10;
    say loop_counter 0, 1, 13, 7, 6, 8, 10, 11, 2, 14, 16, 4, 12, 9, 17, 5, 3, 18, 15, 19;
    say loop_counter 9, 8, 3, 11, 5, 7, 13, 19, 12, 4, 14, 10, 18, 2, 16, 1, 0, 15, 6, 17;
}