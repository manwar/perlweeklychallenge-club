#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

no warnings 'uninitialized';

my @a = (9, 10, 7, 5, 6, 1);

my $leaders = findLeader(\@a);

print "Leaders:\n".Dumper(\@$leaders);

sub findLeader {
    my $elements = shift;
	
    return unless $elements;
	
    my @array_elements = @$elements;
	
    my $length = scalar @array_elements;

    my @result;

    foreach my $i(0..$length-1){
        foreach my $j($i+1..$length){
            last if($array_elements[$i] < $array_elements[$j]);
            push(@result, $array_elements[$i]) if($j == $length-1);
        }
    }
    my $max_from_right = $array_elements[$length-1];
    push (@result, $max_from_right);
	
    return \@result;
}
