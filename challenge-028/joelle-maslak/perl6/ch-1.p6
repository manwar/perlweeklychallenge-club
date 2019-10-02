#!/usr/bin/env perl6
use v6.d;

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

class File-Info {
    my uint8 @print-default;
    BEGIN {
        @print-default.push:   7; # Backspace is considered a printable for this routine's purposes
        @print-default.push:   9; # Horizontal tab
        @print-default.push:  10; # Line Feed
        @print-default.push:  12; # Form Feed
        @print-default.push:  13; # Carriage Return
        @print-default.push: |(32..126);  # All other printables
    }

    has Str:D  $.filename is required;
    has UInt:D $.bytes-to-examine = 512;
    has Set:D  $.printables = Set.new(@print-default);
    has buf8   $!start-block;

    method TWEAK() {
        my $fh = $.filename.IO.open: :r, :bin;
        $!start-block = $fh.read($!bytes-to-examine);
        $fh.close;
    }

    method possibly-ascii-printable(-->Bool:D) {
        return False if 0 ∈ $!start-block;  # Nul chars are automatic binary

        my $unprintable = $!start-block.grep( * ∈ @($!printables) ).elems;
        return False if ($unprintable * 3) > $!start-block.elems;

        # It's possibly ascii.
        return True;
    }
}

sub MAIN(Str:D $filename) {
    my $fi = File-Info.new(:$filename);
    if $fi.possibly-ascii-printable {
        say "The file content is ascii";  # uh, not necessrily.
    } else {
        say "The file content is binary"; # Maybe.
    }
}
