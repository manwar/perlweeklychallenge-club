#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';


### Options and Arguments

my ($tests, $examples, $verbose, $separator);
GetOptions(
    'examples!'   => \$examples,
    'tests!'      => \$tests,
    'verbose!'    => \$verbose,
    'separator=s' => \$separator,
) or usage();

$separator //= '/';

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV;

sub usage {
    die <<~EOS;
    $0 - common path

    usage: $0 [-examples] [-tests] [-separator SEP] [--] [PATH...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -separator SEP
        use the first character from SEP as separator. Default: '/'

    PATH...
        list of paths

    EOS
}


### Input and Output

say common_path($separator, @ARGV) // '';


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/10/18/ch-012.html#task-2

sub common_path ($sep, @paths) {
    my $qs = quotemeta substr $sep, 0, 1;
    my $cp = qr{
        ^
        (?:
            ((?&P)+) (?&T)
            (?: \1 (?&T))*+
        |
            (?=((?&S))) (?&T)++
        )
        \z

        (?(DEFINE)
            (?<S> $qs)                   # Separator
            (?<P> $qs?+ [^$qs\0]++)      # path Part
            (?<T> $qs [^\0]*+ (?:\0|\z)) # path Tail
        )
    }x;
    for (@paths) {
        s/($qs)+/$1/g;
        s/(?:^|$qs)\K\.$qs//g;
        1 while s/(?:$qs|^)[^$qs]*+$qs\.\.(?=\z|$qs)//;
    }

    join("\0", @paths) =~ m{$cp};

    $1 // $2;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = common_path(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[qw(/ /a/b/c/d /a/b/cd /a/b/cc /a/b/c/d/e)],
                "/a/b", 'example'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [[qw(/ /a/b/c//x /a/b/./c///x /a/b/d/e/../../c/x)],
                "/a/b/c", 'multiple separators'],
            [[qw(/ /a/b/c/ /a/b/c/d)], "/a/b/c", 'trailing separator'],
            [[qw(/ /a/b/c/ /a/b/c)], "/a/b", 'missing trailing separator'],
            [['/', "/a/b\nx/c/d", "/a/b\nx/c/e"], "/a/b\nx/c",
                'name contains newline'],
            [[qw(/ /a/b/c/ /a/bc/)], "/a", 'partial name'],
            [[qw(/ /ab/ /bc/)], "/", 'no common name'],
            [[qw(/ / /a/b/c)], "/", 'root dir'],
            [[qw(/ a/b/d a/b/c)], "a/b", 'relative path'],
            [[qw(/ /../../a/b/ /a/./b/)], "/a/b", 'above root'],
            [[qw(/ ./a/b/ a/b/)], "a/b", 'leading dot'],
            [[qw(/ /a/b/./ /a/b/)], "/a/b", 'trailing dot dir'],
            [[qw(/ /a/b/. /a/b/)], "/a/b", 'trailing dot'],
            [['\\', '\\a\\b\\c', '\\a\\b\\d'], '\\a\\b', 'use backslash'],

        );
        plan 2 + scalar @tests;
        run_example @$_ for @tests;
        is common_path('/', qw(/a/b/c/ a/b/c)), U(), 'absolute and relative',
        is common_path('/', qw(a/b/ b/c/)), U(), 'no common relative',
    }) : pass 'skip tests';

    exit;
}
