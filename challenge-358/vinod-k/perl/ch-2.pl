#!/usr/bin/perl
use strict;
use warnings;

sub caesar_encrypt {
    my ($str, $int) = @_;
    $int %= 26;
    
    my $result = '';
    for my $char (split //, $str) {
        if ($char =~ /[a-z]/) {
            $result .= chr( (ord($char) - ord('a') + $int) % 26 + ord('a') );
        } else {
            $result .= $char;
        }
    }
    return $result;
}

# Test cases
my @tests = (
    ["abc", 1, "bcd"],
    ["xyz", 2, "zab"],
    ["abc", 27, "bcd"],
    ["hello", 5, "mjqqt"],
    ["perl", 26, "perl"],
);

print "Running tests:\n";
my $all_pass = 1;
for my $i (0..$#tests) {
    my ($str, $int, $expected) = @{$tests[$i]};
    my $got = caesar_encrypt($str, $int);
    my $pass = $got eq $expected;
    $all_pass &&= $pass;
    print "Example ", $i+1, ": ", $pass ? "PASS" : "FAIL", " (got '$got', expected '$expected')\n";
}

print "\nAll tests passed!\n" if $all_pass;
