#!/usr/bin/perl
use strict;
use warnings;
#use Test::More tests => 4;

if ($ARGV[0]) {
    print fliparray([@ARGV]), "\n";
} 
else {
    print join " ", 1..12,"\n";
    print fliparray([1..12]), "\n";
}

sub num_of_1s_in_a_bit_string {
    my $bitstr = $_[0];
    my @temp = grep {$_ == 1} split "", $bitstr;
    return scalar @temp;
}

sub make_bit_string {
    my $len = $_[0];
    my $dec = $_[1];
    my $a = sprintf("%b", $dec);
    my $addz = $len - length $a;
    if ($addz > 0) {
        $a = "0" x $addz . $a;
    }
    return $a;
}

sub sum_accord_to_bit_string {
    my @arr = @{$_[0]};
    my $bitstr = $_[1];
    my $sum = 0;
    my @sgn = split "",  $bitstr;
    for my $i (0..$#arr) {
        $sum -= $arr[$i] if $sgn[$i] == 1;
        $sum += $arr[$i] if $sgn[$i] == 0;
    }

    return $sum;
}


sub fliparray {
    my @arr = @{$_[0]};
    my $minflip = $#arr;
    my $recordmin = 0;
    $recordmin += $_ for @arr;
    my $recordflip = scalar @arr;

    my $ans_arr;

    for my $b (1..(2**scalar @arr) - 1) {
        my $allsign = make_bit_string(scalar @arr,$b);
        my $sum = sum_accord_to_bit_string(\@arr , $allsign);
        if ( $sum <= $recordmin and $sum >= 0 ) {
            $recordflip = scalar @arr if $sum < $recordmin;
            $recordmin = $sum;
            my $num_of_1s = num_of_1s_in_a_bit_string $allsign;
            if ($recordflip > $num_of_1s and $sum == $recordmin) {
                $recordflip = $num_of_1s; 
                $ans_arr = $allsign;
            }
        }
    }

# assist checking result
=pod
    print $recordflip, "\n";
    print $ans_arr, "\n";
    for my $i (0..$#arr) {
        my @sgn = split "", $ans_arr;
        print " - " if $sgn[$i] == 1;
        print " + " if $sgn[$i] == 0;
        print $arr[$i];
    }
    print "\n";
=cut

    return $recordflip;
}


=pod
ok fliparray([2,10,8]) == 1, "ten";
ok fliparray([3,10,8]) == 1, "example 1";
ok fliparray([1,2,3,4,5,6]) == 2, "one to six";
ok fliparray([1,2,5,6,3,4]) == 2, "one to six,arr";
=cut
