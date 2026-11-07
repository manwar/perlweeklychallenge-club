#!/usr/bin/env perl
use strict;
use warnings;

sub same_difference {
    my ($left, $right) = @_;
    for (my $i = 1; $i < length($left); ++$i) {
        my $a = ord(substr($left, $i, 1)) - ord(substr($left, $i - 1, 1));
        my $b = ord(substr($right, $i, 1)) - ord(substr($right, $i - 1, 1));
        return 0 if $a != $b;
    }
    return 1;
}

# Precondition: precisely one word has a different difference vector.
sub string_difference {
    my (@words) = @_;
    die "Expected at least three strings\n" if @words < 3;
    my $width;
    for my $word (@words) {
        die "Expected ASCII strings\n"
            if !defined($word) || ref($word) || $word =~ /[^\x00-\x7f]/;
        $width = length($word) unless defined($width);
        die "Expected equal-length strings of length at least two\n"
            if $width < 2 || length($word) != $width;
    }

    if (same_difference($words[0], $words[1])) {
        for (my $i = 2; $i < @words; ++$i) {
            return $words[$i] unless same_difference($words[0], $words[$i]);
        }
        die "Input has no exceptional difference vector\n";
    }
    return $words[1] if same_difference($words[0], $words[2]);
    return $words[0] if same_difference($words[1], $words[2]);
    die "Input violates the unique-exception promise\n";
}

sub string_difference_cli {
    if (@_ == 1 && $_[0] eq '--help') {
        print "Usage: perl ch-2.pl WORD WORD WORD [WORD ...]\n";
        return 0;
    }
    my $answer = eval { string_difference(@_) };
    if ($@) {
        print STDERR "Error: $@";
        return 2;
    }
    print "$answer\n";
    return 0;
}

exit string_difference_cli(@ARGV) unless caller;
1;

__END__

=head1 NAME

ch-2.pl - Direct string-difference comparison for Weekly Challenge 398

=head1 DESCRIPTION

Find the exceptional adjacent-character-difference vector among at least three
equal-length ASCII strings of length at least two. The unique-exception promise
is a precondition. Structural validation scans every word before comparison;
complete validation of that semantic promise is not performed.
The callable string_difference function is shared by CLI and batch validation.

Original work by ItsMeSamey with OpenAI Codex assistance. MIT licensed.

=cut
