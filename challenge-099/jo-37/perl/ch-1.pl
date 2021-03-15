#!/usr/bin/perl -s

use v5.20;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [-verbose] [string pattern]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    print generated regex

string
    string to be matched against pattern

pattern
    shell-like pattern

Use '?' inside pattern to match one arbitrary character, '*' to match
any number of characters and '\\' to interpret the following single
character literally.

EOS


### Input and Output

say patmatch($ARGV[0], $ARGV[1]) + 0;


### Implementation

# Convert pattern part to regex:
# *  -> .*
# ?  -> .
# \x -> x
# other: quote if necessary
#
# Processes $_.
sub convmeta {
    return '.*?' if /^\*$/;
    return '.' if /^\?$/;
    return quotemeta $1 if /^\\(.)$/;
    # else:
    quotemeta;
}

# Match string against pattern.  Pattern meta characters are:
# ? : match one character
# * : match any number of characters
# \ : use next character literally
# The special treatment of quoted characters is beyond the specification
# of this task but it seems to be useful and needful.
sub patmatch ($str, $pat) {

    # Convert pattern to regex.
    my $re =  sub {qr/^ @_ $/x}->(
        map convmeta,
        $pat =~ m{
            \G              # start at previous end-of-match position and
            (               # capture
                [^*?\\]+    # a group of non-meta chars
              |             # or    
                [*?]        # a meta-char
              |             # or
                \\.         # a quoted char
            )
        }gx);
    # Reject incomplete patterns.
    die "invalid pattern: '$'' in '$pat'" if $';
    
    say "pattern: '$pat'\nregex:   $re" if $verbose;
    
    $str =~ $re;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        ok patmatch('abcde', 'a*e'), 'example 1';
        ok !patmatch('abcde', 'a*d'), 'example 2';
        ok !patmatch('abcde', '?b*d'), 'example 3';
        ok patmatch('abcde', 'a*c?e'), 'example 4';
    }

    SKIP: {
        skip "tests" unless $tests;
        ok patmatch('ch-1.pl', '*.pl'), 'literal dot matches';
        ok !patmatch('ch-1-pl', '*.pl'), 'literal dot only matches dot';
        ok patmatch('abc.*', '*.\*'), 'literal asterisk matches';
        ok !patmatch('abc.pl', '*.\*'), 'literal asterisk required';
        ok patmatch('ch-[12].pl', '*-[12].pl'), 'literal charclass matches';
        ok !patmatch('ch-1.pl', '*-[12].pl'), 'literal charclass required';
        ok patmatch('ch-1.pl', '*.\p\l'), 'escaped characters';
        ok patmatch('ab\\cd', '??\\\\??'), 'escaped backslash';
        ok patmatch('abbccdde', 'a?*?*?e'), 'matching consecutive meta chars';
        ok !patmatch('abde', 'a?*?*?e'), 'non-matching consecuteive meta chars';
        ok patmatch('äöü', 'ä?ü'), 'handle multi-byte characters';
        like dies {patmatch('ab', 'ab\\')}, qr/invalid pattern/,
            'incomplete quoting sequence';
	}

    done_testing;
    exit;
}
