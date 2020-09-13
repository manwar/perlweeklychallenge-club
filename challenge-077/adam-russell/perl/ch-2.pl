use strict;
use warnings;
##
# You are given m x n character matrix consists of O and X only.
# Write a script to count the total number of X surrounded by O only. 
# Print 0 if none found.
## 
use boolean;
use Lingua::EN::Numbers::Ordinate;

use Data::Dump q/pp/;

my $test0 = [["O", "O", "X"], ["X", "O", "O"], ["X", "O", "O"]];
my $test1 = [["O", "O", "X", "O"], ["X", "O", "O", "O"], ["X", "O", "O", "X"], ["O", "X", "O", "O"]];

sub check_x{
    my($i, $matrix) = @_;
    my @indices = (
        ##
        # For any X we have a maximum of eight places to check
        # which are labelled A, B, C, D, E, F, G, and H.
        #  A B C
        #  D X E
        #  F G H
        ##
        [$i->[0] - 1, $i->[1] - 1], #A
        [$i->[0] - 1, $i->[1]],     #B
        [$i->[0] - 1, $i->[1] + 1], #C
        [$i->[0], $i->[1] - 1],     #D
        [$i->[0], $i->[1] + 1],     #E
        [$i->[0] + 1, $i->[1] - 1], #F
        [$i->[0] + 1, $i->[1]],     #G
        [$i->[0] + 1, $i->[1] + 1]  #H
    );
    for my $check (@indices){
        next if($check->[0] < 0 || $check->[1] < 0);# ignore any impossible (negative index) locations
        next if($check->[0] >= @{$matrix} || $check->[1] >= @{$matrix->[0]});# ignore any impossible (row or column index out of bounds) locations
        return false if($matrix->[$check->[0]]->[$check->[1]] eq "X");
    }
    return true;
}

sub x_search{
    my($matrix) = @_;
    my @x;
    my $row_index = -1;
    for my $row (0 .. (@{$matrix} - 1)){
        $row_index++;
        my $column_index = 0;
        for my $column (0 .. (@{$matrix->[$row_index]} - 1)){
            if($matrix->[$row]->[$column] eq "X"){
                push @x, [$row, $column] if(check_x([$row, $column], $matrix));
            }
        }
    }
    return @x;
}

MAIN:{
    my @x = x_search($test0);
    for my $row (@{$test0}){
        for my $column (@{$row}){
            print "$column ";
        }
        print "\n";
    }
    print "1 X found at Row " . ($x[0]->[0] + 1) . " Column " . ($x[0]->[1] + 1) . ".\n";
    print "\n";
    @x = x_search($test1);
    for my $row (@{$test1}){
        for my $column (@{$row}){
            print "$column ";
        }
        print "\n";
    }
    for my $i (0 .. (@x - 1)){
        print ordinate($i+1) . " X found at Row " . ($x[$i]->[0] + 1) . " Column " . ($x[$i]->[1] + 1) . ".\n";
    }
}