#!/usr/bin/perl
# The Weekly Challenge - Perl & Raku #081 Task 1
# Common Base String
use strict;
use warnings;

sub factors {
    my $n = $_[0];
    my @a = (1);
    for (2..$n) {
        push @a, $_ unless $n % $_
    }
    return @a;
}

sub decompose {
    my $string = $_[0];
    my $strlength = $_[1];
    my $sublength = $_[2];

    my $subst = substr $string, 0, $sublength; 
    my $is = undef;
    $is = $subst if ($subst x ($strlength / $sublength)) eq $string ;
    return $is;
}

sub cbs {
    my ($s1, $s2);
    my @ans;
    if (length $_[0] >= length $_[1]) {
        $s1 = $_[0];
        $s2 = $_[1];
    } 
    else {
        $s2 = $_[0];
        $s1 = $_[1];
    }

    my $ls1 = length $s1;
    my $ls2 = length $s2;

    for my $i (factors($ls2)) {
        my $part_str = decompose($s2, $ls2, $i);
        if ($part_str) {
            push @ans, $part_str if decompose($s1, $ls1, $i);
        }
    }
    return @ans;
}

print join " ", cbs($ARGV[0], $ARGV[1]);
print "\n";
