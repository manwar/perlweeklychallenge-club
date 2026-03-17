#!/usr/bin/env perl

use Modern::Perl;
@ARGV or die "usage: $0 words...\n";
my @words = @ARGV;
say scalar(grep {is_valid($_)} @words);

sub is_valid {
    my($word) = @_;
    return $word =~ / ^ [a-z]+ ( - [a-z]+ )? [!.,]? $ /x;
}
