#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

=head1 DESCRIPTION

Replace all '?' in the given lowercase string so that no two consecutive
characters are identical. Any valid resulting string is acceptable.

=cut

sub replace_question_marks ($str) {
    my @chars = split //, $str;
    my $len   = @chars;
    for my $i (0 .. $len - 1) {
        next unless $chars[$i] eq '?';
        my $prev = $i > 0        ? $chars[$i - 1] : '';
        my $next = $i < $len - 1 ? $chars[$i + 1] : '';
        for my $candidate ('a' .. 'z') {
            next if $candidate eq $prev;
            next if $candidate eq $next;
            $chars[$i] = $candidate;
            last;
        }
    }
    return join '', @chars;
}

if (!caller) {
    require Test::More;
    my $out1 = replace_question_marks('a?z');
    Test::More::like( $out1, qr/^a.z$/, 'Example 1 pattern' );
    Test::More::is( replace_question_marks('pe?k'), 'peak', 'Example 2' );
    my $out3 = replace_question_marks('gra?te');
    Test::More::like( $out3, qr/^gra.te$/, 'Example 3 pattern' );
    Test::More::done_testing();
}
