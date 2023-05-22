#!/usr/bin/env -S perl -wl

#-- algorithm from https://leetcode.com/problems/score-after-flipping-matrix/solutions/2563853/easy-to-understand-basic-python-solution-with-explanation/

use PDL;
use PDL::NiceSlice;
use PDL::AutoLoader;

sub matrix_score {

    local *flip_col = sub {
        my ($col)=@_;
        $matrix($col) .= !$matrix($col);
    };
    
    local *flip_row = sub {
        my ($row)=@_;
        $matrix(,$row) .= !$matrix(,$row);
    };
    
    local *binary_row = sub {
        my ($row)=@_;
        oct '0b' . (join( '', $matrix(,$row)->list));
    };

    #-- main portion of sub
    local ($matrix)=@_; #--pdl
    #-- I leave out input validation chores
    
    my ($ncol, $nrow)=($matrix->dims);
    
    for my $ctr (0 .. $nrow-1) {
    #-- check if row starts with 0, if so, flip
        ($matrix(0,$ctr)==0) && (&flip_row($ctr));
    }
    
    for my $ctr (0 .. $ncol-1) {
    #-- check if number of 1's in column < 0.5 * nrow
    #-- if so, flip column 
    ( ($matrix($ctr)->sum) < ($nrow/2) ) && ( &flip_col($ctr) );
    }
    
    #-- add up binary representations of each row    
    my $retval=0b0;
    for my $ctr (0 .. $nrow-1) {
        $retval += &binary_row($ctr); 
    }
    sprintf("%d",$retval);
}

print &matrix_score(pdl '[0,0,1,1; 1,0,1,0; 1,1,0,0]'); #39
print &matrix_score(pdl '[[0]]'); #1
