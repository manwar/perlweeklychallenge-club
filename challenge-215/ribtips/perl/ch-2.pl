#!/usr/bin/perl

use strict;
use warnings;

&main;

sub main {
    my @nums=(1,0,0,0,1);
    &stuff_in(\@nums,1);
    @nums=(1,0,0,0,1);
    &stuff_in(\@nums,2);
    @nums=(1,0,0,0,0,0,0,0,1);
    &stuff_in(\@nums,3);
}

sub stuff_in {
    my $nums=shift;
    my $count=shift;
    my $inserts=0;
    &print_it($nums);
    for (my $i=1;$i<scalar(@$nums);$i++) {
        if ($$nums[$i] == 0 and $$nums[$i-1] + $$nums[$i+1] == 0) {
            $$nums[$i]=1;
            $inserts++;
        } 
    }
    &print_it($nums);

    if ($inserts == $count) {
        print "Output: 1\n";
    }
    else {
        print "Output: 0\n";
    }

}

sub print_it {
    my $array=shift;
    my $string=join(",",@$array);
    print " ($string) ";
}
