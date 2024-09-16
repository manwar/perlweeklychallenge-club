#!/usr/bin/perl
use strict;
use warnings;
use File::Basename;
use List::Util 'shuffle';
use Test::More tests => 1;

=pod

=head1 DESCRIPTION

This script reads its own source code, splits it into words (anything between whitespace), selects one at random, and prints it.

=head1 FUNCTIONS

=head2 get_random_word()

Reads the script's own source code and returns a random word from it.

Returns: A random word as a string.

=cut

sub get_random_word {
    my $filename = $0;  # $0 contains the name of the script
    open my $fh, '<', $filename or die "Cannot open $filename: $!";
    my @words;
    while (my $line = <$fh>) {
        push @words, split(/\s+/, $line);
    }
    close $fh;
    my $random_word = $words[ rand @words ];
    return $random_word;
}

# Main execution
my $word = get_random_word();
print "$word\n";

# Test to ensure the word is from the source code
subtest 'Test if word is from source code' => sub {
    my $filename = $0;
    open my $fh, '<', $filename or die "Cannot open $filename: $!";
    my $content = do { local $/; <$fh> };
    close $fh;
    like($content, qr/\b\Q$word\E\b/, 'Word is from source code');
};
