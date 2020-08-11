#!/usr/bin/env perl

=head1 unique_prefix

A solution to task 2 of week 57 of the Perl Weekly Challenge.

=cut

use strict;
use warnings;
use Test::More;

my $in = ["alphabet", "book", "carpet", "cadmium", "cadeau", "alpine"];
my $out = ["alph", "b", "car", "cadm", "cade", "alpi"];
is_deeply unique_prefix($in), $out;
done_testing;

=over

=item unique_prefix

Given an arrayref of words, constructs a new arrayref of shortest unique prefixes.

=cut

sub unique_prefix {
    my ($words, $i) = @_;
    $words = [@$words] unless $i; # Clone at the start, alters in place
    $i ||= 1;
    my %c;
    map { $c{substr($_, 0, $i)}++ } @$words;
    foreach(@$words) {
        if ($c{substr($_, 0, $i)} == 1) {
            $_ = substr($_, 0, $i);
        } elsif ($i < length $_) {
            unique_prefix($words, $i+1);
        }
    }
    return $words;
}

=back
