#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(Str);

=pod

=head1 NAME

ch-1.pl - String Compression and Decompression (WWC 296 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

This script implements string compression and decompression using run-length encoding.

For compression:
- For each group of consecutive identical characters:
    - If the count is 1, output the character.
    - If the count is greater than 1, output the count followed by the character.

For decompression:
- Expand the compressed string back to its original form.

=cut

my $STR_CHECK = compile(Str);

sub compress_string ($chars) {
    ($chars) = $STR_CHECK->($chars);
    my $compressed = '';
    my @chars      = split //, $chars;
    my $i          = 0;
    my $n          = scalar @chars;

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

sub decompress_string ($compressed) {
    ($compressed) = $STR_CHECK->($compressed);
    my $decompressed = '';
    my @chars        = split //, $compressed;
    my $i            = 0;
    my $n            = scalar @chars;

    while ( $i < $n ) {
        if ( $chars[$i] =~ /\d/ ) {
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

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "CLI not implemented; run without args for tests\n";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @compress_cases = (
        { label => 'Example 1 Compression', in => 'abbc',    expected => 'a2bc' },
        { label => 'Example 2 Compression', in => 'aaabccc', expected => '3ab3c' },
        { label => 'Example 3 Compression', in => 'abcc',    expected => 'ab2c' },
    );

    my @decompress_cases = (
        { label => 'Example 1 Decompression', in => 'a2bc',  expected => 'abbc' },
        { label => 'Example 2 Decompression', in => '3ab3c', expected => 'aaabccc' },
        { label => 'Example 3 Decompression', in => 'ab2c',  expected => 'abcc' },
    );

    Test::More::plan( tests => scalar( @compress_cases + @decompress_cases ) );
    for my $case (@compress_cases) {
        Test::More::is( compress_string( $case->{in} ), $case->{expected}, $case->{label} );
    }
    for my $case (@decompress_cases) {
        Test::More::is( decompress_string( $case->{in} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 compress_string($chars)

Compresses the input string using run-length encoding.

=head2 decompress_string($compressed)

Decompresses the compressed string back to its original form.

=cut
