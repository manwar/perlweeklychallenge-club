#!/usr/bin/env perl

use v5.35;
use Test2::Bundle::More;

sub ballsAndBoxes{
    my $locations = shift;
    my @boxes;
    my $count = 0;

    for my $ball ($locations =~ m/\w\d/g){
        my ($colour, $box) = split //, $ball;
        if (!exists $boxes[$box]){
            $boxes[$box] = [$colour];
        }
        else {
            push $boxes[$box]->@*, $colour;
        }
    }

    for my $box (0..9){
        if (exists $boxes[$box]){
            my %colours;
            for my $colour ( @{$boxes[$box]} ){
                $colours{$colour} = ();
            }
            if (scalar keys %colours == 3){
                $count++;
            }
        }
    }
    return $count;
}

is(ballsAndBoxes("G0B1R2R0B0"),         1, "Example 1");
is(ballsAndBoxes("G1R3R6B3G6B1B6R1G3"), 3, "Example 2");
is(ballsAndBoxes("B3B2G1B3"),           0, "Example 3");

done_testing();
