#!/usr/bin/env perl
use v5.24;
use strict;
use warnings;

# What is ASCII?
#
# If we go by version 1 ASCII, it's 7 bits to represent characters.
# Assuming these 7 bits are encoded into an 8 bit byte, that means 0-127
# it could be a valid ASCII file.
#
# Of course it might not be too - it could be any other 7 bit encoding
# scheme or it could be an 8 bit encoding scheme that just happens to
# use the lower 7 bits. And ASCII can have the high bit set but ignored.
#
# That said, I'll implement something like Perl 5's -T / -B for Perl 6.
# Note however that Perl 5's -T / -B considers UTF-8 to be printable.
# This program assumes they are not, that we really are looking for 7
# bit ASCII.
#
# I'll assume we want mostly printable ASCII - something you could cat
# to the screen without lots of awful stuff happening.  That means
# looking for (most) control characters.
#
# We will also do this by only looking at the start of the file, like
# Perl 5 does for -T / -B.
#
# Finally, I will assume the OS this is on does not distingush text and
# binary at the file level.

package FileInfo;
use Moose;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

my @print_default;
push @print_default, 7;     # Backspace is considered a printable for this routine's purposes
push @print_default, 9;     # Horizontal tab
push @print_default, 10;    # Line Feed
push @print_default, 12;    # Form Feed
push @print_default, 13;    # Carriage Return
push @print_default, ( 32 .. 126 );    # All other printables

has filename => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has bytes_to_examine => (
    is       => 'ro',
    isa      => 'Int',
    default  => 512,
    required => 1,
);

has printables => (
    is      => 'ro',
    isa     => 'HashRef',
    default => sub {
        return { map { $_, 1 } @print_default };
    },
    required => 1,
);

has start_block => (
    is      => 'ro',
    isa     => 'Str',
    builder => 'build_start_block',
    lazy    => 1,
);

sub build_start_block($self) {
    open my $fh, '<:raw', $self->filename;

    my $block;
    read $fh, $block, $self->bytes_to_examine;

    close $fh;

    return $block;
}

sub possibly_ascii_printable($self) {
    my $unprintable = 0;

    for ( my $i = 0; $i < length( $self->start_block ); $i++ ) {
        my $c = ord( substr( $self->start_block, $i, 1 ) );

        return if $c == 0;    # Nul chars are automatic binary
        $unprintable++ unless exists $self->printables->{$c};
    }

    return if ( $unprintable * 3 ) > length( $self->start_block );

    # It's possibly ascii.
    return 1;
}

package main;
use strict;
use warnings;

MAIN: {
    die "Provide filename (and only filename) as argument" unless @ARGV == 1;
    my $fn = $ARGV[0];

    my $fi = FileInfo->new( { filename => $fn } );
    if ( $fi->possibly_ascii_printable ) {
        say "The file content is ascii";    # uh, not necessrily.
    } else {
        say "The file content is binary";    # Maybe.
    }
}

