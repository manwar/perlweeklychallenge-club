#!/usr/bin/env perl

my $copyright = <<'COPYRIGHT';
# Copyright (c) 2021 by Christian Jaeger <copying@christianjaeger.ch>
# This is free software. See the file COPYING.md that came bundled
# with this file.
COPYRIGHT

=pod

L<The Weekly Challenge - 114|https://perlweeklychallenge.org/blog/perl-weekly-challenge-114/>,

You are given a positive integer $N.

Write a script to find out the next Palindrome Number higher than the given integer $N.

Example

Input: $N = 1234
Output: 1331

Input: $N = 999
Output: 1001


=cut

use strict;
use utf8;
use warnings;
use warnings FATAL => 'uninitialized';
use v5.10;
use experimental 'signatures';
use feature 'current_sub';    # __SUB__

my ($mydir, $myname);

BEGIN {
    $0 =~ /(.*?)([^\/]+)\z/s or die "?";
    ($mydir, $myname) = ($1, $2);
}
use lib "$mydir/../../lib";

#use FunctionalPerl v0.72.69; # recommended
use FP::Predicates qw(is_odd is_defined);
use FP::Lazy;
use FP::Stream;
use Chj::TEST ":all";
use Chj::time_this;

our $verbose = $ENV{VERBOSE};

# XX should be in a lib (or already be on CPAN). Is this faster than
# join('', reverse split //, $str) ?
sub string_reverse ($str) {
    my $out  = "";
    my $len  = length $str;
    my $last = $len - 1;
    for (0 .. $last) {
        substr($out, $_, 1) = substr($str, $last - $_, 1);
    }
    $out
}

TEST { string_reverse "Hello" } 'olleH';
TEST { string_reverse "" } '';
TEST { string_reverse "olleH" } 'Hello';
TEST { string_reverse "oll" } 'llo';
TEST { string_reverse "123" } '321';

# (A) Brute force solution:

sub is_palindrome($n) {
    "$n" eq string_reverse "$n"
}

sub next_palindrome_number__brute($n) {
    stream_iota($n + 1)->filter(\&is_palindrome)->first
}

# (B) Efficient solution:

sub complete_odd($left) {
    $left . string_reverse substr $left, 0, length($left) - 1
}

sub complete_even($left) {
    $left . string_reverse $left
}

TEST { complete_odd 991 } '99199';
TEST { complete_even 991 } '991199';

sub complete ($left, $is_oddlen, $n) {
    my $n2 = $is_oddlen ? complete_odd $left : complete_even $left;
    warn "complete($left, $is_oddlen, $n), n2=$n2" if $verbose;
    if ($n2 <= $n) {
        my $left2      = $left + 1;
        my $is_overrun = length($left2) > length($left);
        unless ($is_overrun) {
            complete($left2, $is_oddlen, $n)
        } else {
            if ($is_oddlen) {
                complete(substr($left2, 0, length($left2) - 1), 0, $n)
            } else {
                complete($left2, 1, $n)
            }
        }
    } else {
        $n2
    }
}

sub next_palindrome_number__optim($n) {
    my $str = "$n";          # yeah, not necessary, but I like to be explicit
    my $len = length $str;
    my $leftlen = int($len / 2 + 0.5);
    my $left    = substr $str, 0, $leftlen;
    complete $left, is_odd($len), $n
}

# ------------------------------------------------------------------
# Allow to switch implementation via env var:
sub next_palindrome_number;
*next_palindrome_number = do {
    if (my $str = $ENV{CHOOSE}) {
        +{
            next_palindrome_number__brute => \&next_palindrome_number__brute,
            next_palindrome_number__optim => \&next_palindrome_number__optim,
        }->{$str}
            or die "invalid CHOOSE value"
    } else {
        \&next_palindrome_number__optim
    }
};

TEST {
    time_this { next_palindrome_number 1628769 }
}
1629261;

TEST { next_palindrome_number 1234 } 1331;
TEST { next_palindrome_number 99 } 101;
TEST { next_palindrome_number 999 } 1001;
TEST { next_palindrome_number 9999 } 10001;
TEST {
    time_this { next_palindrome_number 184827 }
}
185581;
TEST {
    time_this { next_palindrome_number 1848278 }
}
1848481;
TEST {
    time_this { next_palindrome_number 18482789 }
}
18488481;
TEST {
    time_this { next_palindrome_number 162876 }
}
163361;

# Brute test: find a number for which the optimized solution fails:

sub failures ($from) {
    stream_iota($from)->map(
        sub ($n) {
            warn "failures at $n" if $verbose;
            my $a = next_palindrome_number__brute $n;
            my $b = next_palindrome_number__optim $n;
            ($a == $b) ? undef : [$from, $a, $b]
        }
    )->filter(\&is_defined)
}

# Call as `force failures (1)` from the repl, it stops and returns a
# failure if it finds one, otherwise goes on forever.

# UNFINISHED: better test: brute palin and make a series out of it,
# and then check none is different inbetween in optim.

sub palindromes_brute($from) {
    lazy {
        cons $from, palindromes_brute(next_palindrome_number__brute $from)
    }
}

# ...

# ----------------------------------------------------------------------

sub help {
    print "Usage: $0 --repl | --test | n\n";
    exit 1
}

&{
    @ARGV == 1
    ? {
        "--repl" => sub {
            require FP::Repl::Trap;
            FP::Repl::repl();
        },
        "--test" => sub {
            run_tests __PACKAGE__;
        }
    }->{ $ARGV[0] } // sub {
        say next_palindrome_number $ARGV[0]
    }
    : \&help
};

