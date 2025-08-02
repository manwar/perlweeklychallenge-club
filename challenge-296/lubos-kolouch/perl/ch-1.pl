#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 6;

=pod

=head1 DESCRIPTION

This script implements string compression and decompression using run-length encoding.

For compression:
- For each group of consecutive identical characters:
    - If the count is 1, output the character.
    - If the count is greater than 1, output the count followed by the character.

For decompression:
- Expand the compressed string back to its original form.

=head1 FUNCTIONS

=head2 compress_string($chars)

Compresses the input string using run-length encoding as per the problem statement.

=over 4

=item * C<$chars> - The input string consisting of alphabetic characters.

=back

Returns the compressed string.

=cut

sub compress_string {
    my ($chars)    = @_;
    my $compressed = '';
    my @chars      = split //, $chars;
    my $i          = 0;
    my $n          = @chars;
    while ( $i < $n ) {
        my $current_char = $chars[$i];
        my $count        = 1;
        while ( $i + 1 < $n && $chars[ $i + 1 ] eq $current_char ) {
            $count++;
            $i++;
        }
        if ( $count > 1 ) {
            $compressed .= $count . $current_char;
        }
        else {
            $compressed .= $current_char;
        }
        $i++;
    }
    return $compressed;
}

=head2 decompress_string($compressed)

Decompresses the compressed string back to its original form.

=over 4

=item * C<$compressed> - The compressed string.

=back

Returns the original uncompressed string.

=cut

sub decompress_string {
    my ($compressed) = @_;
    my $decompressed = '';
    my @chars        = split //, $compressed;
    my $i            = 0;
    my $n            = @chars;
    while ( $i < $n ) {
        if ( $chars[$i] =~ /\d/ ) {

            # Collect the full number (in case of multiple digits)
            my $count = '';
            while ( $i < $n && $chars[$i] =~ /\d/ ) {
                $count .= $chars[$i];
                $i++;
            }
            my $char = $chars[$i];
            $decompressed .= $char x $count;
            $i++;
        }
        else {
            $decompressed .= $chars[$i];
            $i++;
        }
    }
    return $decompressed;
}

# Unit Tests
is( compress_string("abbc"),    "a2bc",  'Example 1 Compression' );
is( compress_string("aaabccc"), "3ab3c", 'Example 2 Compression' );
is( compress_string("abcc"),    "ab2c",  'Example 3 Compression' );

is( decompress_string("a2bc"),  "abbc",    'Example 1 Decompression' );
is( decompress_string("3ab3c"), "aaabccc", 'Example 2 Decompression' );
is( decompress_string("ab2c"),  "abcc",    'Example 3 Decompression' );

done_testing();
