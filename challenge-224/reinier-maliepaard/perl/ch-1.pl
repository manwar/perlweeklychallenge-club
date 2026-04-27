#!/usr/bin/perl
use strict;
use warnings;

sub special_notes {
    my ($source, $target) = @_;

    $source = lc $source;
    $target = lc $target;

    my %count;
    $count{$_}++ for split //, $source;

    for my $char (split //, $target) {
        return 0 if !exists $count{$char} || $count{$char} == 0;
        # this would be enough: return 0 if !$count{$char};
        $count{$char}--;
    }

    return 1;
}

# Tests

my $source;
my $target;

# Example 1
$source = "abc";
$target = "xyz";
print special_notes($source, $target) ? "true\n" : "false\n"; # Output: false

# Example 2
$source = "scriptinglanguage";
$target = "perl";
print special_notes($source, $target) ? "true\n" : "false\n"; # Output: true

# Example 3
$source = "aabbcc";
$target = "abc";
print special_notes($source, $target) ? "true\n" : "false\n"; # Output: true
