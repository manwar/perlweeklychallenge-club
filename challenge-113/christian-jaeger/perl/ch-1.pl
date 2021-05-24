#!/usr/bin/env perl

my $copyright = <<'COPYRIGHT';
# Copyright (c) 2021 by Christian Jaeger <copying@christianjaeger.ch>
# This is free software. See the file COPYING.md that came bundled
# with this file.
COPYRIGHT

=pod

L<The Weekly Challenge - 113|https://perlweeklychallenge.org/blog/perl-weekly-challenge-113/>,
TASK #1: Represent Integer

You are given a positive integer $N and a digit $D.

Write a script to check if $N can be represented as a sum of positive
integers [all] having $D at least once [in their decimal
representation]. If check passes print 1 otherwise 0.

=head1 NOTE

There is a Haskell version of this script in the file
L<113-1-represent_integer_haskell.hs>.

There is a L<blog post about this|http://functional-perl.org/docs/blog/perl-weekly-challenges-113.xhtml>.

=cut

use strict;
use utf8;
use warnings;
use warnings FATAL => 'uninitialized';
use experimental 'signatures';
use feature 'current_sub';    # __SUB__

my ($mydir, $myname);

BEGIN {
    $0 =~ /(.*?)([^\/]+)\z/s or die "?";
    ($mydir, $myname) = ($1, $2);
}
use lib "$mydir/../../lib";

use FunctionalPerl v0.72.65;
use FP::Docstring;
use FP::Show;
use FP::List;
use FP::PureArray;
use FP::Lazy;
use FP::Either ":all";
use FP::Predicates qw(is_defined);
use Chj::TEST ":all";
use Chj::time_this;

our $verbose = $ENV{VERBOSE};

sub maybe_choose_brute ($N, $ns) {
    __ 'Choose a combination of numbers from $ns (repetitions allowed)
        that added together equal $N; undef if not possible. This
        solution is brute force in that it is picking additional
        numbers from the left end of $ns, one after another,
        depth-first.';

    sub ($chosen) {
        my $check = __SUB__;
        warn "check (brute): " . show($chosen) if $verbose;
        my $sum = $chosen->sum;
        if ($sum == $N) {
            $chosen
        } elsif ($sum > $N) {
            undef
        } else {
            $ns->any(
                sub ($n) {
                    $check->(cons($n, $chosen))
                }
            )
        }
        }
        ->(null)
}

sub maybe_choose_optim_1 ($N, $ns) {
    __ 'Choose a combination of numbers from $ns (repetitions allowed)
        that added together equal $N; undef if not possible. This
        solution uses a hashtable to check for each additional number;
        i.e. it tries to minimize the number of numbers taken from
        $ns (it is still searching depth-first).';
    my %ns = map { $_ => 1 } $ns->values;

    sub ($chosen) {
        my $check = __SUB__;
        warn "check (optim 1): " . show($chosen) if $verbose;
        my $sum     = $chosen->sum;
        my $missing = $N - $sum;
        if (not $missing) {
            $chosen
        } elsif ($missing < 0) {
            undef
        } else {
            if (exists $ns{$missing}) {
                cons $missing, $chosen
            } else {
                $ns->any(
                    sub ($n) {
                        $check->(cons($n, $chosen))
                    }
                )
            }
        }
        }
        ->(null)
}

sub maybe_choose_optim_2 ($N, $_ns) {
    __ 'Choose a combination of numbers (repetitions allowed) from $ns
        which must be sorted in decrementing order that added together
        equal $N; undef if not possible. This solution does a
        breadth-first search (and uses the hashtable check to see if
        there will be a match with the next level like
        maybe_choose_optim_1)';

    # We want to use lazy evaluation to allow for the descriptive
    # solution below, thus turn the purearray to a lazy list:
    my $ns = $_ns->stream;

    my %ns = map { $_ => 1 } $_ns->values;

    sub ($chosen) {
        my $check = __SUB__;
        warn "check (optim 2): " . show($chosen) if $verbose;

        # Given an additional choice of a number $n (out of $ns) on
        # top of $chosen, decide whether there's a solution either
        # with the given numbers or when adding one more missing
        # number by looking at %ns; or whether the chosen numbers are
        # adding up to too much already (in which case undef is
        # returned), or the search needs to resume via recursively
        # calling $check. The latter case is not carried out
        # immediately, but returned as a lazy term (a promise), to
        # allow to delay diving deeper into the next recursion level
        # to *after* checking all numbers in the current level
        # (breadth-first search).

        # Using FP::Either's `Right` to indicate an immediate
        # solution, `Left` to indicate a case that needs recursion
        # (and only potentially yields a result), undef to signify a
        # dead end.

        my $decide = sub ($n) {
            warn "decide: checking $n on top of " . show($chosen) if $verbose;
            my $chosen  = cons $n, $chosen;
            my $missing = $N - ($chosen->sum);
            if (not $missing) {
                Right $chosen
            } elsif ($missing < 0) {
                undef
            } else {
                if (exists $ns{$missing}) {
                    Right cons($missing, $chosen)
                } else {
                    Left lazy {
                        $check->($chosen)
                    }
                }
            }
        };

        # Since $ns are sorted in decrementing order, if $decide
        # returns undef, any subsequent number will fail, too, so we
        # can stop further checks; `take_while` will only take the
        # results up to that point.

        # Since $ns is a stream (a lazily computed list), the
        # following `map` and `take_while` steps are lazy, too;
        # $decide will never be evaluated for $n's that are smaller
        # (coming further along in the reverse-ordered $ns) than any
        # $n that can lead to a solution.

        my $decisions = $ns->map($decide)->take_while(\&is_defined);

        # Check for immediate solutions (solutions on our level)
        # first, if that fails, get and evaluate the promises to
        # recurse (go deeper):

        my $solutions  = rights $decisions;
        my $recursions = lefts $decisions;
        unless ($solutions->is_null) {
            $solutions->first
        } else {
            $recursions->any(\&force)
        }
        }
        ->(null)
}

# (But there may be smarter algorithms.)

sub valid_numbers ($N, $D) {
    purearray grep {/$D/} (1 .. $N)
}

# You can explicitely choose the algorithm it via setting
# `MAYBE_CHOOSE` env var to its name, or by passing its reference as
# the 4th argument to maybe_representable.
my $MAYBE_CHOOSE = do {
    if (my $str = $ENV{MAYBE_CHOOSE}) {
        +{
            maybe_choose_brute   => \&maybe_choose_brute,
            maybe_choose_optim_1 => \&maybe_choose_optim_1,
            maybe_choose_optim_2 => \&maybe_choose_optim_2
        }->{$str}
            or die "invalid MAYBE_CHOOSE value"
    } else {
        undef
    }
};

sub maybe_representable ($N, $D, $prefer_large = 1,
    $maybe_choose = $MAYBE_CHOOSE)
{
    __ 'Returns the numbers containing $D that sum up to $N, or undef.
        If $prefer_large is true, tries to use large numbers,
        otherwise small (which is (much) less efficient).';
    my $ns = valid_numbers($N, $D);
    $maybe_choose
        //= ($prefer_large and not $ENV{NO_OPTIM})
        ? \&maybe_choose_optim_2
        : \&maybe_choose_brute;
    $maybe_choose->($N, $prefer_large ? $ns->reverse : $ns)
}

TEST { maybe_representable 25, 7 } undef;
TEST { maybe_representable 24, 7 } list(7, 17);

TEST { maybe_representable 200, 9 } list(9, 191);
TEST { maybe_representable 200, 9, 0 }
list(29, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9);

# The comments to the right in the following show the results that
# maybe_choose_optim_1 gave:

TEST { maybe_representable 200, 8 } list(18, 182);    # list(8, 8, 184);
TEST { maybe_representable 200, 8, 0 }
list(8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8);

TEST { maybe_representable 200, 7 } list(27, 173);    # list(7, 7, 7, 179);

TEST { maybe_representable 200, 6 } list(36, 164);    # list(6, 6, 6, 6, 176);

unless ($ENV{NO_EXPENSIVE_TESTS}) {
    TEST {
        time_this { maybe_representable 20000, 8 }
    }
    list(18, 19982);                                  # list(8, 8, 19984);
    TEST {
        time_this { maybe_representable 40000, 8 }
    }
    list(18, 39982);                                  # list(8, 8, 39984);
    TEST {
        time_this { maybe_representable 40000, 6 }
    }
    list(36, 39964);                                  # list(6, 6, 6, 6, 39976);
}

# ----------------------------------------------------------------------

sub help {
    print "Usage: $0 --repl | --test\n";
    exit 1
}

&{
    @ARGV
    ? {
        "--repl" => sub {
            require FP::Repl::Trap;
            FP::Repl::repl();
        },
        "--test" => sub {
            run_tests __PACKAGE__;
        }
        }->{ $ARGV[0] } // \&help
    : \&help
};

