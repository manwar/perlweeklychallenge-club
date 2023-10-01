#!/usr/bin/perl
use v5.36;
use List::Util 'any';

my %till;
my $failure;
foreach my $bill (@ARGV) {
    if(!any {$bill == $_} (5, 10, 20)) {
        say('At least one bill provided is not $5, $10, or $20.') and exit;
    }
    $till{$bill}++;
    if($bill == 20) {
        if($till{10} and $till{5}) {
            $till{10}--;
            $till{5}--;
        } elsif($till{5} >= 3) {
            $till{5} -= 3;
        } else {
            $failure = 'false';
            last;
        }
    } elsif($bill == 10) {
        if($till{5}) {
            $till{5}--;
        } else {
            $failure = 'false';
            last;
        }
    }
}
say(defined($failure) ? $failure : 'true');
