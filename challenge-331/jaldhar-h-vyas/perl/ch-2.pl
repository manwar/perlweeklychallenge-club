#!/usr/bin/perl
use 5.038;
use warnings;
use builtin qw/ true false /;
no warnings qw/ experimental::builtin /;

sub isBuddyString($source, $target) {

    if (length($source) != length($target)) {
        return false;
    }

    if ($source eq $target) {
        my %count;

        for my $c (split //, $source) {
            $count{$c}++;
        }

        return grep { $_ > 1 } values %count ? true : false;
    }

    my $diff = 0;
 
    for my $i (0 .. length($source) - 1) {
        if (substr($source, $i, 1) ne substr($target, $i, 1)){
            $diff++;
        }
    }

    if ($diff != 2) {
        return false;
    }

    return true;
}

my ($source, $target) = @ARGV;

if (!defined $source || !defined $target) {
    die "Usage: $0 source target\n";
}

say isBuddyString($source, $target) ? "True" : "False";
