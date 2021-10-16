#!/usr/bin/perl -s

use v5.16;
use Math::Prime::Util 'fromdigits';
use Coro::Generator;
use Test2::V0 '!hash';
no warnings 'recursion';
use experimental qw(signatures postderef);

our ($tests, $examples, $verbose, $base);
$base = 10 unless $base and $base >= 2;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless  @ARGV == 1;
usage: $0 [-examples] [-tests] [-verbose] [-base=B] [-extra] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    trace numbers in the given base

-base=B
    use base B.  Default: 10

N
    print the first N base-B pandigital numbers.

EOS


### Input and Output

main: {
    my $pdn = pdngen($base);
    say $pdn->() for 1 .. shift;
}


### Implementation

# A helper sub to solve the task: Enumerate all tuples of LENGTH items
# from the list ITEMS that contain all elements of the subset REQ of
# ITEMS.  This can be regarded as extended permutations of REQ (or
# restricted tuples of ITEMS).  As special cases it includes all tuples
# and permutations only: If REQ is empty, it enumerates all tuples of
# length LENGTH.  If REQ contains all ITEMS and LENGTH equals the number
# of items, it enumerates the permutations.
# I don't know if such an enumeration already has a name.
# 
# Usage:
#   forextperm BLOCK ITEMS,REQ,LENGTH[,HEAD]
# where BLOCK is a code block, ITEMS is an array and REQ is a hash ref.
# This calls BLOCK for all matching tuples (with @_ set to the current
# tuple) in lexicographical order as defined by the ITEMS list.  The
# found tuples are prefixed with the elements of the optional array ref
# HEAD.  Though his was meant as an internal feature only, it turned out
# to be useful for this task.

sub forextperm :prototype(&\@$$;$) ($code, $items, $req, $len, $head=[]) {
    die "too many required items" if $len < keys %$req;
    # If the remaining length exceeds the number of required items, any
    # item may be placed at the current position.
    my $any = $len > keys %$req;
    # Loop over all possible items at the current position.
    for my $item (grep {$any or exists $req->{$_}} @$items) {
        if ($len == 1) {
            # Call CODE for complete tuples.
            $code->(@$head, $item);
        } else {
            # Recurse into self with the adjusted set of required items,
            # a decremented length and the current item appended to the
            # head.  Need to circumvent the prototype to be able to pass
            # the code ref.
            &forextperm($code, $items, remove($req, $item),
                $len - 1, [@$head, $item]);
        }
    }
}


# Two handy helper subs:

# Create a hash ref with the sub's arguments as keys.
sub hash {
    my $hash;
    $hash->@{@_} = ();
    $hash;
}

# Create a copy of %$hash and remove @elems from it.
sub remove ($hash, @elems) {
    my $copy = {%$hash};
    delete $copy->@{@elems};
    $copy;
}

# The actual implementation:
# Build a generator for the pandigital numbers in base $base.

sub pdngen ($base) {
    # Get an ordered list of all possible "digits" (which are actually
    # integers for bases larger than 10) and a corresponding hash.
    my @digits = (0 .. $base - 1);
    my $req = hash @digits;

    generator {
        # Two nested loops to ensure ascending order and non-zero
        # leading digits:
        # An infinite loop over all possible lengths.
        for (my $len = @digits;; $len++) {
            # A loop over non-zero leading digits.
            for my $f (@digits[1 .. $#digits]) {
                # Find all numbers having the current leading digit, not
                # requiring it in the remainder and having one digit
                # less than the current length.
                forextperm {
                    say "@_ (", scalar @digits, ')' if $verbose;
                    yield fromdigits \@_, @digits;
                } @digits, remove($req, $f), $len - 1, [$f];
            }
        }
    }
}


### Examples and tests

sub run_tests {

    SKIP: {
        skip "examples" unless $examples;

        my $pdn = pdngen(10);
        is [map {$pdn->()} 1 .. 5],
            [1023456789, 1023456798, 1023456879, 1023456897, 1023456978],
            'first five decimal pandigital numbers'
    }

    SKIP: {
        skip "tests" unless $tests;

        # pndgen tests

        {
            my $pdn = pdngen(2);
            is [map $pdn->(), 1 .. 12],
                [2, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 16],
                'first binary pandigital numbers';
        }

        {
            my $pdn = pdngen(3);
            $pdn->() for 1 .. 28;
            is $pdn->(), 83,
                'smallest five-digit ternary pandigital number';
        }

        is pdngen(36)->(),
            '2959962226643665039859858867133882191922999717199870715',
            'smallest hexatrigesimal pandigital number, see Wiki';

        {
            my $pdn = pdngen(8);
            $pdn->() for 1 .. 35279;
            is $pdn->(), 076543210,
                'largest non-redundant octal pandigital number';
        }

        # forextperm tests

        {
            my @items = qw(a b c);
            my %result;
            forextperm {
                $result{"@_"} = undef;
            } @items, {}, 3;
            is scalar(keys %result), 27, 'all tuples';
        }

        {
            my @items = qw(a b c);
            my %result;
            forextperm {
                $result{"@_"} = undef;
            } @items, hash(@items), 3;
            is scalar(keys %result), 6, 'all permutations';
        }

        {
            my @items = qw(a b c);
            like dies {
                forextperm { } @items, hash(@items), @items - 1;
            }, qr(too many required items), 'too many required items';
        }

        {
            my @items = qw(a b);
            my @result;
            forextperm {
                push @result, join '', @_;
            } @items, hash(@items), 3;
            is \@result, [qw(aab aba abb baa bab bba)],
               'three of two';
        }
	}

    done_testing;
    exit;
}
