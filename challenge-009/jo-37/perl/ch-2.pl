#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::UtilsBy 'rev_nsort_by';
use experimental 'postderef';

use constant R_DENSE => 0;
use constant R_STD => 1;
use constant R_MOD => 2;

our ($tests, $examples, $mod, $dense);

my $mode = R_STD;
$mode = R_MOD if $mod;
$mode = R_DENSE if $dense;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-mod | -dense] [ID:SCORE...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-mod
    use "modified ranking"

-dense
    use "dense ranking"

ID:SCORE
    list of identifier / score pairs

EOS


### Input and Output
say "$_->{id}:$_->{rank}" for
@{rank($mode, map {my %h; @h{qw(id score)} = split /:/; \%h} @ARGV)};


### Implementation


# Expecting a list of hash refs with two required keys: id and score. Id
# is an identifier for the item and score a number, where larger numbers
# are regarded as "better".  First sort the list descending by score.
# Then collect references to the value for the key "rank".  Equal scores
# go into the same array.  Then assign ranks according to the selected
# mode. 
sub rank {
    my $mode = shift;

    # sort descending
    my @sorted = rev_nsort_by {$_->{score}} @_;
    # collect references:
    my $lastscore = 'inf';
    my @ranks;
    for (@sorted) {
        if ($_->{score} < $lastscore) {
            # a lower score opens a new rank group
            push @ranks, [\$_->{rank}];
        } else {
            # an equal score goes into the corresponding group
            push $ranks[-1]->@*, \$_->{rank};
        }
        $lastscore = $_->{score};
    }
    my $rank = 0;
    for (@ranks) {
        # Prepend a gap in "modified" mode, step otherwise
        $rank += ($mode == R_MOD) ? @$_ : 1;
        $$_ = $rank for @$_;
        # Append a gap in "standard" mode
        $rank += ($mode == R_STD) * ($#$_);
    }

    \@sorted;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        my @items = (
            {id => 'B', score => 1},
            {id => 'C', score => 2},
            {id => 'D', score => 2},
            {id => 'A', score =>3}
        );

        like rank(R_STD, @items),
            bag {item hash {field id => 'B'; field rank => 4};
                item hash {field id => 'C'; field rank => 2};
                item hash {field id => 'D'; field rank => 2};
                item hash {field id => 'A'; field rank => 1};
                end;
            }, 'standard rank';
        like rank(R_MOD, @items),
            bag {item hash {field id => 'B'; field rank => 4};
                item hash {field id => 'C'; field rank => 3};
                item hash {field id => 'D'; field rank => 3};
                item hash {field id => 'A'; field rank => 1};
                end;
            }, 'modified rank';
        like rank(R_DENSE, @items),
            bag {item hash {field id => 'B'; field rank => 3};
                item hash {field id => 'C'; field rank => 2};
                item hash {field id => 'D'; field rank => 2};
                item hash {field id => 'A'; field rank => 1};
                end;
            }, 'dense rank';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
