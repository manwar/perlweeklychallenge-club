#!/usr/bin/perl

use strict;
use warnings;

&main;

sub main {
    print "Test 1: ";
    my @words=('abc', 'abcd', 'bcd');
    my $reg = 'AB1 2CD';
    my $matches=&find_matches(\@words,$reg);
    &print_output($matches);
    print "Test 2: ";
    @words=('job', 'james', 'bjorg');
    $reg = '007 JB';
    $matches=&find_matches(\@words,$reg);
    &print_output($matches);
    @words=('crack', 'road', 'rac');
    $reg = 'C7 RA2';
    $matches=&find_matches(\@words,$reg);
    print "Test 3: ";
    &print_output($matches);
}

sub print_output {
    my $matches_array=shift;
    my $matches=join("', '",@$matches_array);
    print "('$matches')\n";
}

sub find_matches {
    my $words=shift;
    my $reg=shift;
    my @results=();
    foreach my $word (@$words) {
        my $result=&compare_words($reg,$word); 
        if ($result == 1) {
            push @results,$word;
        }
    }
    return \@results;
}

sub compare_words {
    my $reg=shift;
    my $word=shift;
    $reg=lc($reg);
    my @reg=split//,$reg;
    foreach my $letter (@reg) {
        if ($letter =~ m/[a-z]/) {
            if ($word =~ m/$letter/) {
                #good 
            }
            else {
                return 0;
            }
        }
    }
    return 1;
}
