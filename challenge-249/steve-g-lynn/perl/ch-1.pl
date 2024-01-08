#!/usr/bin/env -S perl -wl

use Data::Dumper qw(Dumper);

local *equal_pairs = sub {
    #-- return () if input is of odd length
    ((scalar(@_) % 2) > 0) && (return ());
    
    #-- count number of occurrences of each element using a hash
    local %_ = ();
    map {$_{$_}++} @_;
    
    #-- if any element occurs an odd number of times, return ()
    (grep {($_{$_} % 2) > 0} keys %_) && (return ());
    
    #-- loop thru %_ keys, returning pairs of such keys
    map {
        my $k=$_; 
        my $num_pairs=( ($_{$k}) / 2 );
        map {
            [$k, $k]
        } 1 .. $num_pairs;    
    } 
    keys %_;    
};

print Dumper &equal_pairs(3,2,3,2,2,2);
#$VAR1 = [
#          '3',
#          '3'
#        ];
#$VAR2 = [
#          '2',
#          '2'
#        ];
#$VAR3 = [
#          '2',
#          '2'
#        ];

print Dumper &equal_pairs(1,2,3,4);
# no printed output (empty array)

1;
