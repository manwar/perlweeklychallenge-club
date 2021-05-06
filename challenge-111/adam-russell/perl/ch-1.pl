use strict;
use warnings;
##
# You are given 5x5 matrix filled with integers such that each row 
# is sorted from left to right and the first integer of each row is 
# greater than the last integer of the previous row.
# Write a script to find a given integer in the matrix using an efficient 
# search algorithm.
##
use boolean;      
use constant MATRIX_SIZE => 5;   

use Data::Dump q/pp/;  

sub matrix_search{
    my($matrix, $search) = @_;
    unless(@{$matrix} == 1){  
        my $half = int(@{$matrix} / 2);      
        if($matrix->[$half]->[0] > $search){
            my @matrix_reduced = @{$matrix}[0 .. $half - 1];
            matrix_search(\@matrix_reduced, $search);    
        }  
        elsif($matrix->[$half]->[0] < $search){
            my @matrix_reduced = @{$matrix}[$half .. @{$matrix} - 1];
            matrix_search(\@matrix_reduced, $search);    
        }  
        elsif($matrix->[$half]->[0] == $search){
            return true;  
        } 
    }
    else{
        return row_search($matrix->[0], $search);  
    }    
}

sub row_search{
    my ($row, $search) = @_; 
    unless(@{$row} == 1){
        my $half = int(@{$row} / 2);  
        if($row->[$half] > $search){
            my @row_reduced = @{$row}[0 .. $half - 1];
            row_search(\@row_reduced, $search);    
        }  
        elsif($row->[$half] < $search){
            my @row_reduced = @{$row}[$half .. @{$row} - 1];
            row_search(\@row_reduced, $search);    
        }  
        elsif($row->[$half] == $search){
            return true;
        }  
    } 
    else{
        return false;
    }   
} 

MAIN:{
    my $N = [[  1,  2,  3,  5,  7 ],  
             [  9, 11, 15, 19, 20 ],   
             [ 23, 24, 25, 29, 31 ],    
             [ 32, 33, 39, 40, 42 ],   
             [ 45, 47, 48, 49, 50 ]];
    my $search = 35;
    print matrix_search($N, $search) . "\n";
    $search = 39;
    print matrix_search($N, $search) . "\n";
}
