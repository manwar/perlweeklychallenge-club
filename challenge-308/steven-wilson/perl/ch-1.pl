#!/usr/bin/env perl

use v5.35;
use Test2::Bundle::More;

sub countCommon{
    my ($ref1, $ref2) = @_;
    my %strings1;
    $strings1{$_}++ for (@$ref1);
    my %strings2;
    $strings2{$_}++ for (@$ref2);
    my @intersection = grep { exists $strings1{$_} } keys %strings2;
    return scalar @intersection;
}

my @str1 = ("perl", "weekly", "challenge");
my @str2 = ("raku", "weekly", "challenge");
is(countCommon(\@str1, \@str2), 2, "Test 1");

my @str3 = ("perl", "raku", "python");
my @str4 = ("python", "java");
is(countCommon(\@str3, \@str4), 1, "Test 2");

my @str5 = ("guest", "contribution");
my @str6 = ("fun", "weekly", "challenge");
is(countCommon(\@str5, \@str6), 0, "Test 3");

done_testing();
