#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

=head1 NAME

CountPrefixes - Count strings starting with a given prefix

=head1 SYNOPSIS

    use strict;
    use warnings;
    use lib '.';
    require CountPrefixes;

    my $count = count_prefixes("ab", "abc", "abx", "bcd", "abe");  # 3

=head1 DESCRIPTION

Given a prefix and a list of strings, count how many strings start with the prefix.

=head1 SUBROUTINES

=head2 count_prefixes($prefix, @strings)

    my $count = count_prefixes("ab", "abc", "abx", "bcd", "abe");

Counts how many strings in the list start with the given prefix.

Parameters:
    $prefix  - the prefix to search for
    @strings - list of strings to check

Returns:
    Number of strings that start with the prefix.

=cut

sub count_prefixes {
    my ($prefix, @strings) = @_;

    die "Error: prefix must be defined\n" unless defined $prefix;
    die "Error: strings must be defined\n" unless @strings;

    my $count = 0;
    for my $str (@strings) {
        $count++ if $str =~ /^\Q$prefix\E/;
    }

    return $count;
}

=head2 _prefix_match($str, $prefix)

    my $matches = _prefix_match("abc", "ab");  # 1

Helper function to check if a string starts with a prefix.

=cut

sub _prefix_match {
    my ($str, $prefix) = @_;
    return $str =~ /^\Q$prefix\E/;
}

is(count_prefixes("ab", "abc", "abx", "bcd", "abe"), 3, 'Example 1: 3 strings start with "ab"');
is(count_prefixes("x", "xyz", "x", "xy", "abc"), 3, 'Example 2: 3 strings start with "x"');
is(count_prefixes("hello", "hello world", "hello", "world", "hello there"), 3, 'Example 3: 3 strings start with "hello"');
is(count_prefixes("", "a", "b", "c"), 3, 'Example 4: empty prefix matches all');
is(count_prefixes("z", "a", "b", "c"), 0, 'Example 5: no matches');

done_testing();
