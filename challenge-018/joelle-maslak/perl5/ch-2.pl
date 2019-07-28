#!/usr/bin/env perl
use v5.22;
use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use autodie;

# See lib/PriorityQueue.pm
use PriorityQueue;

use Test2::V0;

my $pk = PriorityQueue->new();

subtest 'Start empty' => sub {
    ok $pk->is_empty();
};

subtest 'One element insert' => sub {
    $pk->insert_with_priority( 'A', 50 );
    ok !$pk->is_empty;
    is $pk->pull_highest_priority_element, 'A';
    ok $pk->is_empty;
};

subtest 'With Multiple Priorities' => sub {
    $pk->insert_with_priority( 'A', 50 );
    $pk->insert_with_priority( 'B', 50 );
    $pk->insert_with_priority( 'C', 75 );
    $pk->insert_with_priority( 'D', 50 );
    $pk->insert_with_priority( 'E', 10 );
    $pk->insert_with_priority( 'F', 10 );

    ok !$pk->is_empty;
    is $pk->pull_highest_priority_element(), 'C';

    $pk->insert_with_priority( 'G', 75 );
    is $pk->pull_highest_priority_element(), 'G';

    is $pk->pull_highest_priority_element(), 'A';
    is $pk->pull_highest_priority_element(), 'B';
    is $pk->pull_highest_priority_element(), 'D';
    is $pk->pull_highest_priority_element(), 'E';
    is $pk->pull_highest_priority_element(), 'F';

    ok $pk->is_empty;
};

done_testing;

