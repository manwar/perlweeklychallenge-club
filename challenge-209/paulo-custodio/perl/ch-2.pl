#!/usr/bin/perl

# Challenge 209
#
# Task 2: Merge Account
# Submitted by: Mohammad S Anwar
#
# You are given an array of accounts i.e. name with list of email addresses.
#
# Write a script to merge the accounts where possible. The accounts can only
# be merged if they have at least one email address in common.
#
# Example 1:
#
# Input: @accounts = [ ["A", "a1@a.com", "a2@a.com"],
#                      ["B", "b1@b.com"],
#                      ["A", "a3@a.com", "a1@a.com"] ]
#                    ]
#
# Output: [ ["A", "a1@a.com", "a2@a.com", "a3@a.com"],
#           ["B", "b1@b.com"] ]
#
# Example 2:
#
# Input: @accounts = [ ["A", "a1@a.com", "a2@a.com"],
#                      ["B", "b1@b.com"],
#                      ["A", "a3@a.com"],
#                      ["B", "b2@b.com", "b1@b.com"] ]
#
# Output: [ ["A", "a1@a.com", "a2@a.com"],
#           ["A", "a3@a.com"],
#           ["B", "b1@b.com", "b2@b.com"] ]

use Modern::Perl;

sub parse_input {
    my(@argv) = @_;
    my @accounts;
    my $i=0;
    while ($i < @argv) {
        my $j=$i;
        while ($j < @argv && $argv[$j] ne ',') {
            $j++;
        }
        push @accounts, [@argv[$i..$j-1]];
        $i=$j+1;
    }
    return @accounts;
}

sub common_email {
    my(@accounts)=@_;
    my %mails;
    for my $i (0..$#accounts) {
        for my $j (1..$#{$accounts[$i]}) {
            my $mail = $accounts[$i][$j];
            if (exists $mails{$mail}) {
                return ($mails{$mail}, $i);
            }
            else {
                $mails{$mail}=$i;
            }
        }
    }
    return;
}

sub merge_accounts {
    my(@accounts)=@_;
    while (my($a,$b)=common_email(@accounts)) {
        # merge a and b
        my %mails;
        for my $i (1..$#{$accounts[$a]}) { $mails{$accounts[$a][$i]}=1; }
        for my $i (1..$#{$accounts[$b]}) { $mails{$accounts[$b][$i]}=1; }
        $accounts[$a]=[$accounts[$a][0], sort keys %mails];
        splice(@accounts,$b,1);
    }
    return @accounts;
}

sub print_accounts {
    my(@accounts) = @_;
    for (@accounts) {
        say join(" ", @$_);
    }
}

my @accounts=merge_accounts(parse_input(@ARGV));
print_accounts(@accounts);
