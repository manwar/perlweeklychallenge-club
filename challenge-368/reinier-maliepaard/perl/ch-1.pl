#!/usr/bin/perl
use strict;
use warnings;

sub make_it_bigger {
    my ($str, $char) = @_;

    die "Invalid input\n"
        unless defined $str
        && defined $char
        && $str =~ /^\d+$/
        && $char =~ /^\d$/
        && (() = $str =~ /\Q$char\E/g) == 2; # /\Q$char\E/ escapes $char so special regex characters are treated literally.

    # find index first occurrence of $char
    my $i = index($str, $char);
    # find index second occurrence of $char
    my $j = index($str, $char, $i + 1);

    # quasi following the instructions:
    # remove first occurence of $char in $a, i.e. first copy of $str
    my $a = $str; substr($a, $i, 1, '');
    # remove second occurence of $char in $b, i.e. second copy of $str
    my $b = $str; substr($b, $j, 1, '');

    # or shorter, without removing $char:
    # my $a = substr($str, 0, $i) . substr($str, $i + 1);
    # my $b = substr($str, 0, $j) . substr($str, $j + 1);

    $a > $b ? $a : $b;
}

# Tests

my $str;
my $char;

# Example 1
$str = "34545";
$char = "5";
print make_it_bigger($str, $char), "\n"; # Output: 3454

# Example 2
$str = "7332";
$char = "3";
print make_it_bigger($str, $char), "\n"; # Output: "732"

# Example 3
$str = "2231";
$char = "2";
print make_it_bigger($str, $char), "\n"; # Output: "231"

# Example 4
$str = "543251";
$char = "5";
print make_it_bigger($str, $char), "\n"; # Output: "54321"

# Example 5
$str = "1921";
$char = "1";
print make_it_bigger($str, $char), "\n"; # Output: "921"
