#!/usr/bin/env perl

# Perl Weekly Challenge 212 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-212/

use Modern::Perl;

sub rearrange_groups {
    my($size, @nums) = @_;
    return -1 unless scalar(@nums) % $size == 0;
    my %nums; $nums{$_}++ for @nums;
    my @output;
    while (%nums) {
        my $min = (sort {$a<=>$b} keys %nums)[0];
        my @group;
        for my $j ($min .. $min+$size-1) {
            return -1 unless $nums{$j};
            push @group, $j;
            $nums{$j}--;
            delete $nums{$j} if $nums{$j}==0;
        }
        push @output, \@group;
    }
    return @output;
}

sub print_groups {
    my(@output) = @_;
    if (@output==1 && !ref($output[0])) {
        say $output[0];
    }
    else {
        my $sep = "";
        for (@output) {
            print $sep,"(",join(",", @$_),")";
            $sep = ", ";
        }
        print "\n";
    }
}

my @nums = @ARGV;
my $size = pop(@nums);
print_groups(rearrange_groups($size, @nums));
