use strict;
use warnings;
##
# You are given a rectangle with points 
# marked with either x or *. Consider 
# the x as a land mine. Write a script 
# to print a rectangle with numbers 
# and x as in the Minesweeper game.
##
sub initialize_grid{
    my($m, $n) = @_;
    my @grid; 
    for my $i (0 .. $m - 1){
        for my $j (0 .. $n - 1){
            $grid[$i][$j] = "*";   
            $grid[$i][$j] = "x" if rand() <= (1 / 3);   
        }  
    }  
    return @grid; 
}

sub make_grid{
    my($m, $n) = @_;
    my @initial_grid = initialize_grid($m, $n);  
    my @grid = map {[@$_]} @initial_grid; 
    for my $i (0 .. $m - 1){ 
        for my $j (0 .. $n - 1){
            unless($grid[$i][$j] eq "x"){
                my $mine_count = 0;
                $mine_count++ if $i >= 1 && $j >= 1 && $grid[$i - 1][$j - 1] eq "x"; 
                $mine_count++ if $i >= 1 && $grid[$i - 1][$j] eq "x"; 
                $mine_count++ if $i >=1 && $j < $n - 1 && $grid[$i - 1][$j + 1] eq "x"; 
                $mine_count++ if $j >= 1 && $grid[$i][$j - 1] eq "x"; 
                $mine_count++ if $j < $n - 1 && $grid[$i][$j + 1] eq "x"; 
                $mine_count++ if $i < $m - 1 && $j >= 1 && $grid[$i + 1][$j - 1] eq "x"; 
                $mine_count++ if $i < $m - 1 && $grid[$i + 1][$j] eq "x" ; 
                $mine_count++ if $i < $m - 1 && $j < $n - 1 && $grid[$i + 1][$j + 1] eq "x"; 
                $grid[$i][$j] = $mine_count; 
            } 
        }  
    } 
    return (\@initial_grid, \@grid); 
}  

sub print_grid{
    my @grid = @_; 
    for my $row (@grid){
        print "\t" . join(" ", @{$row}) . "\n"  
    } 
} 

MAIN:{
    my($m, $n) = @ARGV;
    my($initial_grid, $grid) = make_grid($m, $n);  
    print "Input:\n"; 
    print_grid(@{$initial_grid});      
    print "Output:\n"; 
    print_grid(@{$grid});      
}
