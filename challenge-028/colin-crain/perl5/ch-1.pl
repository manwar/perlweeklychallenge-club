#! /opt/local/bin/perl
#
#       text_or_binary.pl
#
#       28 Task #1:
#       Write a script to check the file content without actually reading
#           the content. It should accept file name with path as command
#           line argument and print “The file content is binary.” or else
#           “The file content is ascii.” accordingly.
#
#       method: This sounds like a koan: read a file without reading it. So I
#           interpreted "reading" here as meaning "open it up and examine to
#           see if the characters print text or pseudo-random garbage." However even
#           this simplification proves problematic on close examination.
#
#           I considered opening a filehandle, using 'read' to grab a few
#           thousand bytes, and then using a regex to search for control
#           characters in the bytestream that should never be present in
#           textfile, or checking for too many bytes with the high-bit set, or
#           even checking the bytes as hex digits for randomness. These
#           approaches would work pretty well for ascii but less so for UTF-8.
#           For UTF-8 we would need to unpack the octets and see if high-bit
#           bytes are proper leading bytes for multi-byte unicode characters.
#
#           It's also debatable whether using 'read' at all counts as 'reading the
#           content', but I have to count that as semantic squabbling and move on.
#
#           The thing is, this statistical method is exactly what the -T and -B
#           operators do: read in a few thousand bytes and make a good educated
#           guess based on nonprinting control characters and characters with the
#           high bit set. -T also does a check to see if it's nothing but valid
#           UTF-8, high bits and all, so we do that filetest first. So why reinvent
#           the wheel? Also, if explicitly using 'read' is not allowed then
#           implicitly doing the same thing beneath the surface leaves us in the
#           same boat. So here we are.
#
#           It is worthy to note that in the end the analysis remains
#           statistical and cannot be perfectly accurate. I've altered the
#           output to reflect this. There will always be edge-case files that
#           defy accurate categorization. pdf files, for example, contain a lot
#           of embedded ascii plain text surrounded by binary data, and,
#           depending on how you look at it, can appear to be either, even
#           though they should properly be considered a binary file containing
#           blocks of textual data. But even this can be taken to a pathological
#           extreme: does a multi-megabyte text file prefaced by a minimal
#           header of few bytes of binary data suddenly become a binary file?
#
#           I think the answer is context-specific, so can only be “it depends”.
#
#
#       colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

my $file = shift @ARGV;

if  (not defined $file)     { die "enter a valid file path to check status\n" }
if  (not -f $file)      { die "argument \"$file\" does not appear to be a valid file path\n"};

if  (-T $file)      { say "The file content is most likely text."
elsif   (-B $file)      { say "The file content is most likey binary." }

## it's not exactly clear whether a pathological case can exist that fails both tests,
## but I suspect it may.
else                { say "problem grokking file $file, cannot decide what it is." }

