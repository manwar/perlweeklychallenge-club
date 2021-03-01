#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental qw(signatures postderef);
use Syntax::Keyword::Gather;
use Math::Utils 'ceil';
use List::Util 'min';
use Parallel::Subs;
use utf8;

our ($tests, $examples, $long, $single);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-long] [L]

-examples
    run the examples from the challenge. (This may take some seconds or
    even longer to complete - depending on the hardware.)
 
-tests
    run some tests

-long
    enable long running tasks (L > 9)

L
    number of decimal digits

EOS


### Input and Output

if ($single) {
    # for testing only
    say $_ for @{rare_nums_in(@ARGV)};
} else {
    die "use '-long' to enable long running task" if $ARGV[0] > 9 && !$long;
    say $_ for rare_nums_len($ARGV[0]);
}


### Implementation

# Rare numbers: a chimaera out of perfect squares and reversed decimal
# digits.
#
# Putting the cart before the horse:
# Let n be a number and r its reverse.
# n + r = x², n - r = y² => n = (x² + y²)/2, r = (x² - y²)/2.
# Iterating over pairs of squares having a half-sum within the given
# interval [low, high).  This is not the fastest solution, but it has a
# fun factor.
# It must hold x ≡ y mod 2 for an even square sum, leading to
# x + y ≡ 0 mod 2 and x - y ≡ 0 mod 2. From
# r = (x² - y²)/2 = (x + y)(x - y)/2
# it follows, that r ≡ 0 mod 2 and thus n must start with an even digit.
#
# Combining possible end digits from pairs of perfect squares, taking
# the difference divided by 2 and taking into account that the
# difference must be even, it leads to possible end digits for r
# depending on the end digits of x² and y²:
#
#  x| 0 1 4 5 6 9
# y |
# --+------------
# 0 | 0   2   8
# 1 |   0   2   4
# 4 | 8   0   6
# 5 |   8   0   2
# 6 | 2   4   0
# 9 |   6   8   0
#
# As the ending digit of r must agree with the leading digit of n, this
# gives a mapping from n's leading digit to x²'s possible ending digits:
# 2 -> 0, 4, 5, 9
# 4 -> 4, 9
# 6 -> 1, 6
# 8 -> 0, 1, 5, 6

BEGIN {
    %::l2e = (
        0 => qr/./,         # no leading digit given
        2 => qr/[0459]/,
        4 => qr/[49]/,
        6 => qr/[16]/,
        8 => qr/[0156]/);
}

sub rare_nums_in {
    my ($low, $high, $lead) = @_;
    $lead //= 0;
    my @rare;

    # Find the smallest x, such that there is an y <= x - 2
    # with (x² + y²)/2 >= low.
    my $x = ceil(1 + sqrt($low - 1));

    my $x2 = $x**2;

    # Single limit for x².
    while ($x2 < 2 * $high) {
        # Skip nonmatching end digits.
        next unless ($x2 % 10) =~ $::l2e{$lead};

        # smallest y between current x and lower limit
        my $y = $x2 < 2*$low ? ceil(sqrt(2*$low - $x2)) : 0;

        # No more floating point operations from here.  Release the
        # handbreak.
        use integer;

        # Adjust mod 2.
        $y++ if ($x + $y) % 2;

        # smallest y ≡ x mod 2.
        my $ymin = $x % 2 ? 1 : 2;

        # Adjust if too small.
        $y = $ymin if $y < $ymin;

        my $y2 = $y**2;

        # Two limits for y²: it must be smaller than x² and the half
        # square sum must be below the upper limit.
        my $y2max = min $x2, 2 * $high - $x2;
        while ($y2 < $y2max) {
            # Check if n and r are the reverse of each other.
            # Multiple usage of the same expression is cheaper than
            # using an extra variable.
            push @rare, ($x2 + $y2)/2 
                if reverse(($x2 + $y2)/2) == ($x2 - $y2)/2;
        } continue {
             $y2 = ($y += 2)**2;
        }
    } continue {
        $x2 = (++$x)**2;
    }

    \@rare;
}

# Divide search into subtasks.
# Calculate lower and upper limit for individual sub tasks.  All numbers
# within the interval have the same first digit.
# Generate list of [$lower, $upper, $lead]
sub split_task ($len) {

    my $numcpu = Sys::Info->new->device('CPU')->count;
    my $size = 10 ** ($len-1) / $numcpu;

    gather {
        for my $lead (2, 4, 6, 8) {
            my $start = $lead * 10 ** ($len-1);
            for my $s (1 .. $numcpu) {
                take [$start + int(($s - 1) * $size),
                    $start + int($s * $size), $lead];
            }
        }
    };
}

# Collect all rare numbers having $l decimal digits.  The task is
# separated into several sub tasks that are executed in parallel on
# available cpu cores.
sub rare_nums_len ($len) {
    # Don't split small tasks.
    return @{rare_nums_in(10**($len-1), 10**$len)} if $len < 4;

    my $p = Parallel::Subs->new;
    for my $lim (split_task($len)) {
        $p->add(sub{rare_nums_in($lim->@*)});
    }
    $p->wait_for_all;

    map $_->@*, $p->results->@*;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is [rare_nums_len 2], [65], 'example a';
        is [rare_nums_len 6], [621770], 'example b';
        is [rare_nums_len 9], [281089082], 'example c';
    }

    SKIP: {
        skip "tests" unless $tests;
        
        is [rare_nums_len 4], [], 'len 4';
        is [rare_nums_len 5], [], 'len 5';
        is [rare_nums_len 7], [], 'len 7';
        is [rare_nums_len 8], [], 'len 8';

        skip "long running" unless $long;
        is [rare_nums_len 10], [2022652202, 2042832002], 'len 10';
	}

    done_testing;
    exit;
}
