#!/usr/bin/env -S perl -wl

#real	0m23.427s
#user	0m23.300s
#sys	0m0.015s


use List::Util qw(sum);
use Math::Utils qw(hcf);

local *linear_recurrence_2 = sub {
    local *is_int = sub {
       ($_[0] =~ /^[-]?[0-9]+$/ ) || (return 0);
       ($_[0] - int($_[0])) == 0;
    };
    
    #-- input validation (vector of 5 integers)
    
    (@_ == 5) || return "linear_recurrence_2: Input must have 5 elements.";
    
    (sum( map {&is_int($_)} @_ )==5) || return "linear_recurrence_2: Input must be integers."; 
    
    @_ = map {int($_)} @_;

    (scalar(grep {$_==0} @_)==5) && (return 1);
    (($_[0]==0) && ($_[1]==0) && ($_[2] != 0)) && (return 0);
    (($_[1]==0) && ($_[2]==0) && ($_[3] != 0)) && (return 0);
    (($_[2]==0) && ($_[3]==0) && ($_[4] != 0)) && (return 0);
    (($_[0] != 0) && ($_[1]==0) && ($_[2]==0)) && (return 1); #-- must be of the form (x,0,0,0,0)  
    
    #-- if hcf of 1st 2 elements does not divide into all others, reject
    if (($_[0] != 0) && ($_[1] != 0)){
        local $hcf=hcf( $_[0],$_[1] );
        ( grep { ($_ % $hcf) != 0 } @_[2..4] ) && (return 0);
    }

    {
    #-- solve for p and q from 1st 2 triplets. Check if is_int.
    #-- p*a[0]+q*a[1]=a[2]; p*a[1]+q*a[2]=a[3];
    local ($p, $q);
    
    if (($_[0]==0) && ($_[1] != 0)) {
        $q=$_[2]/$_[1];
        $p=($_[3]-$_[2]*$q)/$_[1];
    }
    elsif (($_[0] != 0) && ($_[1] == 0) && ($_[2] != 0)) {
        $p=$_[2]/$_[0];
        $q=$_[3]/$_[2];
    }
    elsif (($_[0] != 0) && ($_[1] != 0) && ($_[2] == 0)) {
        $p=$_[3]/$_[1];
        $q = -($p*$_[0])/$_[1];
    }
    elsif ( abs($_[1]/$_[0] - $_[2]/$_[1]) < 0.000001 ) {
        local $ratio = $_[1]/$_[0];
        ($_[3]/$_[2] != $ratio) && return 0;
        ($_[4]/$_[3] != $ratio) ? (return 0) : (return 1);
    }
    else {
        $q= ($_[2]/$_[0]-$_[3]/$_[1]) /
            ($_[1]/$_[0]-$_[2]/$_[1]);
    
        $p=($_[2]/$_[1]-$_[3]/$_[2]) /
            ($_[0]/$_[1]-$_[1]/$_[2]);

    }
    
    &is_int($q) || return 0;
    &is_int($p) || return 0;
    
    ($p*$_[2]+$q*$_[3]==$_[4]) || return 0;
    print "p: ",$p," q: ",$q;
    return 1;
    }
    
    
};

print "Ex1 1,1,2,3,5: ", &linear_recurrence_2(1,1,2,3,5); #1
print "Ex2 4,2,4,5,7: ", &linear_recurrence_2(4,2,4,5,7); #0
print "Ex3 4,1,2,-3,8: ", &linear_recurrence_2(4,1,2,-3,8); #1
print "(1,0,0,0,0): ",&linear_recurrence_2(1,0,0,0,0); #1 [p=q=0]
print "--------------";
print "";

local *test_lr2 = sub {
#-- Test &linear_recurrence_2 further:
#-- create 1 nillion 5-element integer vectors
#-- with elements between -9 and 9
#-- and print out those that are linear recurrences of order 2
    local *rand_seq = sub {    
        local @rand_seq = map {rand} -9 .. 9;
        return (sort {$rand_seq[$a+9] <=> $rand_seq[$b+9]} -9 .. 9) [0 .. 4];
    };
  
    my $ctr=0;
    for (1 .. 1_000_000)  {
        local @test_lr2 = &rand_seq;
        if (&linear_recurrence_2(@test_lr2)) { 
            print "@test_lr2"; $ctr++;
        }
    }
    print "--------\nNUMBER OF LINEAR RECURRENCES SECOND ORDER (out of 1,000,000): ",$ctr;  
};

&test_lr2;
