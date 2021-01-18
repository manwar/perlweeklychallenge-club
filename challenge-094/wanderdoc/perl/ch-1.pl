#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of strings @S. Write a script to group Anagrams together in any random order.

Example 1: Input: ("opt", "bat", "saw", "tab", "pot", "top", "was")
    Output: [ ("bat", "tab"), ("saw", "was"), ("top", "pot", "opt") ]
Example 2: Input: ("x") Output: [ ("x") ]
=cut





my @groups = group_anagrams("opt", "bat", "saw", "tab", "pot", "top", "was");
print join(", ", @$_), $/ for @groups; 
print $/;
@groups = group_anagrams("x"); 
print join(", ", @$_), $/ for @groups;

sub group_anagrams
{
     my @strings = @_;

     my %anagrams;
     push @{$anagrams{_standard($_)}}, $_ for @strings;
     return values %anagrams;
}

sub _standard
{
     my $string = $_[0];
     return join('',sort {$a cmp $b} split(//,$string));
}