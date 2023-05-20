#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

&main;

sub main {
    my @list=(1,23);
    &big_num(\@list);
    @list=(10,3,2);
    &big_num(\@list);
    @list=(31,2,4,10);
    &big_num(\@list);
    @list=(5,11,4,1,2);
    &big_num(\@list);
    @list=(1,10);
    &big_num(\@list);
}

sub big_num {
    my $list=shift;
    my %nums=();

    foreach my $num (@$list) {
        foreach my $digit (0..9) {
            if ($num =~ m/^$digit/) {
                push(@{$nums{$digit}},$num);
                last;
            }
        }
    }
    
    my $big_num="";

    foreach my $key (reverse sort keys %nums) {
        my @sorted=sort {$a<=>$b} @{$nums{$key}};
        my $lil_num=join '',@sorted;
        $big_num=$big_num.$lil_num;    
    }

    print "Output: $big_num\n";

}
