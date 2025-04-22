#!/usr/bin/env perl

use v5.35;
use Test2::Bundle::More;

sub acronyms{
    my ($words, $word) = @_;
    my $first =  join "", map { substr($_, 0, 1) } @$words;
    return $first eq $word;
}

ok(acronyms(["Perl", "Weekly", "Challenge"], "PWC"));
ok(acronyms(["Bob", "Charlie", "Joe"], "BCJ"));
ok(!acronyms(["Morning", "Good"], "MM"));

done_testing();
