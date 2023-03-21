#!/usr/bin/perl

use strict;
use warnings;
use Test::More tests => 1;

sub merge_email_lists {
    my @accounts = @_;

    my @merged_lists;

    # Process the input and create the merged lists
    foreach my $account (@accounts) {
        my ($list_name, @emails) = @$account;
        my $list_found = 0;

        # Check if the list name already exists in the merged lists
        foreach my $merged_list (@merged_lists) {
            my ($merged_name, @merged_emails) = @$merged_list;

            # If the list names match and they share a common email address, merge the lists
            if ($list_name eq $merged_name && (grep { my $email = $_; grep { $email eq $_ } @emails } @merged_emails)) {
                push @$merged_list, @emails;
                $list_found = 1;
                last;
            }
        }

        # If the list name is not found in the merged lists, add the current list
        push @merged_lists, $account unless $list_found;
    }

    # Remove duplicate email addresses from each list and sort them
    foreach my $merged_list (@merged_lists) {
        my ($list_name, @emails) = @$merged_list;
        my %seen;
        @$merged_list = ($list_name, sort grep { !$seen{$_}++ } @emails);
    }

    return \@merged_lists;
}

# Test data
my @test_accounts = (
    ["A", 'a1@@a.com', 'a2@@a.com'],
    ["B", 'b1@@b.com'],
    ["A", 'a3@@a.com'],
    ["B", 'b2@@b.com', 'b1@@b.com']
);

# Test result
my $merged_email_lists = merge_email_lists(@test_accounts);
my @expected_email_lists = (
    ["A", 'a1@@a.com', 'a2@@a.com'],
    ["B", 'b1@@b.com', 'b2@@b.com'],
    ["A", 'a3@@a.com']
);

# Perform the test
is_deeply($merged_email_lists, \@expected_email_lists, 'Test merging email lists with common email addresses');

