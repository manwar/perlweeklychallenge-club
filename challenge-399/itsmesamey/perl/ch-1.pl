#!/usr/bin/env perl
use strict;
use warnings;
use Encode qw(decode FB_CROAK);

sub longest_repeating_character {
    my ($text, $budget) = @_;
    die "Expected a string and a nonnegative integer\n"
        if !defined($text) || ref($text) || !defined($budget)
        || ref($budget) || $budget !~ /\A[0-9]+\z/;

    my @characters = split //, $text;
    return scalar @characters if $budget >= @characters;
    my (%counts, $left, $most, $best);
    ($left, $most, $best) = (0, 0, 0);

    for my $right (0 .. $#characters) {
        my $count = ++$counts{$characters[$right]};
        $most = $count if $count > $most;
        # A past maximum is enough when only the best length is needed.
        while ($right - $left + 1 - $most > $budget) {
            --$counts{$characters[$left]};
            ++$left;
        }
        my $length = $right - $left + 1;
        $best = $length if $length > $best;
    }
    return $best;
}

sub longest_repeating_character_cli {
    if (@_ == 1 && $_[0] eq '--help') {
        print "Usage: perl ch-1.pl STRING K\n";
        return 0;
    }
    if (@_ != 2) {
        print STDERR "Usage: perl ch-1.pl STRING K\n";
        return 2;
    }
    my ($text, $budget) = @_;
    my $answer = eval {
        $text = decode('UTF-8', $text, FB_CROAK);
        longest_repeating_character($text, $budget);
    };
    if ($@) {
        print STDERR "Error: $@";
        return 2;
    }
    print "$answer\n";
    return 0;
}

exit longest_repeating_character_cli(@ARGV) unless caller;
1;

__END__

=head1 NAME

ch-1.pl - Longest Repeating Character for Weekly Challenge 399

=head1 DESCRIPTION

Use a sliding window and character counts to find the greatest length reachable
with at most K replacements. The callable function accepts Perl character strings;
the CLI decodes UTF-8 arguments. Empty strings and K = 0 are also supported.

=cut
