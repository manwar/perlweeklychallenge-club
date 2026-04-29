#!/usr/bin/perl
use strict;
use warnings;

sub sort_language {

    my ($language, $popularity) = @_;
    my @res;

    for (my $i=0; $i < scalar(@$popularity); $i++) { # alternative: # for my $i (0 .. @$popularity-1) {
        my $pop_index = $popularity->[$i];
        $res[$pop_index-1] = $language->[$i];
    }

    return @res;
}

# Tests

my (@lang, @popularity);

# Example 1
@lang = ('perl', 'c', 'python');
@popularity = (2, 1, 3);
print "('", join("', '", sort_language(\@lang, \@popularity)), "')\n"; # Output: ('c', 'perl', 'python')

# Example 2
@lang = ('c++', 'haskell', 'java');
@popularity = (1, 3, 2);
print "('", join("', '", sort_language(\@lang, \@popularity)), "')\n"; # Output: ('c++', 'java', 'haskell')
