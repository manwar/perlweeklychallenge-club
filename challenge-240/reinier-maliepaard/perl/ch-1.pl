#!/usr/bin/perl
use strict;
use warnings;

sub acronym {

    my ($chk, $aref) = @_;

    my $res;

    for (@$aref) {
    	$res .= substr($_, 0, 1);
    }
    return ( (lc $res) eq $chk ) ? "true" : "false";
}

# Tests

my (@str, $chk);

# Example 1
@str = ("Perl", "Python", "Pascal");
$chk = "ppp";
print acronym($chk, \@str), "\n"; # Output: true

# Example 2
@str = ("Perl", "Raku");
$chk = "rp";
print acronym($chk, \@str), "\n"; # Output: false

# Example 3
@str = ("Oracle", "Awk", "C");
$chk = "oac";
print acronym($chk, \@str), "\n"; # Output: true
