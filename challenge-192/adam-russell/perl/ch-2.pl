use v5.36;
##
# You are given a list of integers greater than or equal to zero, @list.
# Write a script to distribute the number so that each members are same. 
# If you succeed then print the total moves otherwise print -1.
# Please follow these rules:
#    1) You can only move a value of '1' per move
#    2) You are only allowed to move a value of '1' to a direct neighbor/adjacent cell
##
use POSIX;

sub equal_distribution{
    my(@integers) = @_;
    my $moves;
    my $average = unpack("%32I*", pack("I*",  @integers)) / @integers; 
    return -1 unless floor($average) ==  ceil($average);
    {
        map{
            my $i = $_;
            if($integers[$i] > $average && $integers[$i] > $integers[$i+1]){$integers[$i]--; $integers[$i+1]++; $moves++}
            if($integers[$i] < $average && $integers[$i] < $integers[$i+1]){$integers[$i]++; $integers[$i+1]--; $moves++}
        } 0 .. @integers - 2;
        redo unless 0 == grep {$average != $_} @integers;
    }
    return $moves;
}

MAIN:{
    say equal_distribution(1, 0, 5);
    say equal_distribution(0, 2, 0);
    say equal_distribution(0, 3, 0);
}