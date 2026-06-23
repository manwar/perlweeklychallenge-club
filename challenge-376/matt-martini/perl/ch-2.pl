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

use Dev::Util::Syntax;
use Test2::V0;
plan tests => 5;

use lib '.';
use PWC;
my $json_data = get_json_data();

is( doubled_words( $_->{ in } ), $_->{ out }->[0], $_->{ name } )
    for $json_data->{ examples }->@*;

sub doubled_words {
    my $str = $_[0]->[0];
    print_inputs( $json_data->{ input_vars }, @_ );
    my $result = q{};
    my $dub_word_re = qr{\b([a-z]+)((?:\s|<[^>]+>)+)(\g1\b)}ix;

    $str =~ s{$dub_word_re}{\[$1\]$2\[$3\]}g;
    $result = join "\n", grep { $_ =~ m/\[/ } split "\n", $str;

    print_outputs($result);
    return $result;
}
