#!/usr/bin/env perl

# You are given a string (which may contain embedded newlines) which is
# taken from a page on a website. The string will not contain brackets
# qw{ [ ] }.

# Write a script that will find doubled words (such as “this this”)
# and highlight (wrap in brackets) each doubled word.

# The script should:

# - Work across lines, even finding situations where a word at the end of
#   one line is repeated at the beginning of the next.

# - Find doubled words despite capitalization differences, such as with
#   'The the...', as well as allow differing amounts of whitespace
#   (spaces, tabs, newlines, and the like) to lie between the words.

# - Find doubled words even when separated by HTML tags. For example, to
#   make a word bold: '...it is <B>very</B> very important...'. Only show
#   lines containing doubled words.

# Adapted from Mastering Regular Expressions, Third Edition by Jeffrey E. F. Friedl

use 5.018;
use strict;
use warnings;
use File::JSON::Slurper qw(read_json);
use Data::Printer;

use Test2::V0;
plan tests => 5;

my $json_ref = read_json( __FILE__ =~ s/pl$/json/r )
    or die "ERROR: could not read test data from json file\n";
my $challenge_ref  = $json_ref->{ challenge };
my $input_vars_ref = $json_ref->{ input_vars };
my $examples_ref   = $json_ref->{ examples };

printf qq{Challenge: %s Task %s: %s\n\n},
    $challenge_ref->{ week },
    $challenge_ref->{ task },
    $challenge_ref->{ name };

is( doubled_words( $_->{ in } ), $_->{ out }->[0], $_->{ name } )
    for @{ $examples_ref };

sub doubled_words {
    my $str = $_[0]->[0];
    printf qq{Input: %s = "%s"\n}, $input_vars_ref->[0], $str;
    my $result = q{};
    my $dub_word_re = qr{\b([a-z]+)((?:\s|<[^>]+>)+)(\g1\b)}ix;

    $str =~ s{$dub_word_re}{\[$1\]$2\[$3\]}g;
    $result = join "\n", grep { $_ =~ m/\[/ } split "\n", $str;

    printf qq{Output: %s\n}, $result;
    return $result;
}
