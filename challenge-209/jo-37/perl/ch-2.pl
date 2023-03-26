#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Util 'pairs';
use List::MoreUtils qw(minmax part);
use experimental qw(signatures postderef);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [--] [NAME,ADDR,... ]

-examples
    run the examples from the challenge
 
-tests
    run some tests

NAME,ADDR,... NAME,ADDR,...
    account list from names and associated addresses

EOS


### Input and Output

say "@$_" for @{merge_accounts([map [split /,/], @ARGV])};


### Implementation

# Two accounts shall be merged if they have at least one address in
# common.  Regarding this merger as transitive: Though in the three
# lists
# 1) addr1 addr2
# 2) addr2 addr3
# 3) addr3 addr4
# lists 1) and 3) do not have a common address, all three will be merged
# into one because 1) and 2) can be merged as well as 2) and 3).
# There is no specific order in the resulting merged accounts.

sub merge_accounts ($accounts) {
    my %accounts;
    # Convert the account list to a hash mapping the name to all its
    # address lists.
    push $accounts{$_->[0]}->@*, [$_->@[1 .. $#$_]] for @$accounts;
    my @result;
    # Loop over names.
    for my $pair (pairs %accounts) {
        my ($name, $addrlists) = @$pair;
        my %reverse;
        # Build a reverse map from each address to the list indices the
        # address is contained in.
        for my $i (0 .. $#$addrlists) {
            push $reverse{$_}->@*, $i for @{$addrlists->[$i]};
        }
        # Initialize a merge map from every list index to the final
        # consolidated index.
        my @map = (0 .. $#$addrlists);
        # Consolidate addresses as long as there is any progress.
        my $progress;
        do {
            $progress = 0;
            # Loop over the index lists a single address is contained
            # in.
            for my $ind (values %reverse) {
                # All these indices shall be consolidated into a single
                # list.  There is progress if the list contains more
                # than one map target.
                my ($min, $max) = minmax @map[@$ind];
                $progress ||= $min < $max;
                # Map all indices to the smallest.
                @map[@$ind] = ($min) x @$ind;
            }
        } while $progress;
        # Distribute the addresses to the consolidated lists.
        my @merged = part {$map[$reverse{$_}[0]]} keys %reverse;
        # Create an account for every remaining pair of name and address
        # list.
        push @result, [$name, $_->@*] for grep defined, @merged;
    }
    \@result;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        like merge_accounts([
                ["A", 'a1@a.com', 'a2@a.com'],
                ["B", 'b1@b.com'],
                ["A", 'a3@a.com', 'a1@a.com']]),
             bag {
                 item array {
                     item 'A';
                     filter_items {
                         bag {item 'a1@a.com'; item 'a2@a.com';
                             item 'a3@a.com'; end;}
                     };
                 };
                 item array {
                     item 'B';
                     filter_items {
                         bag {item 'b1@b.com'; end;}
                     };
                 };
                 end;
             },
             'example 1';
        like merge_accounts([
                ['A', 'a1@a.com', 'a2@a.com'],
                ['B', 'b1@b.com'],
                ['A', 'a3@a.com'],
                ['B', 'b2@b.com', 'b1@b.com']]),
            bag {
                item array {
                    item 'A';
                    filter_items {
                        bag {item 'a1@a.com'; item 'a2@a.com'; end;}
                    };
                };
                item array {
                    item 'A';
                    filter_items {
                        bag {item 'a3@a.com'; end;}
                    };
                };
                item array {
                    item 'B';
                    filter_items {
                        bag {item 'b1@b.com'; item 'b2@b.com'; end;}
                    };
                };
                end;
            }, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        like merge_accounts([
                [qw(A addr1 addr2)],
                [qw(A addr2 addr3)],
                [qw(A addr3 addr4)],
                [qw(A addr5 addr6)]]),
        bag {
            item array {
                item 'A';
                filter_items {
                    bag {item 'addr1'; item 'addr2'; item 'addr3';
                        item 'addr4'; end;}
                };
            };
            item array {
                item 'A';
                filter_items {
                    bag {item 'addr5'; item 'addr6'; end;}
                };
            };
        }, 'merge three accounts pairwise';

	}

    done_testing;
    exit;
}
