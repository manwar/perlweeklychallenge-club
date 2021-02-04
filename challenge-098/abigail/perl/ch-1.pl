#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-1.pl < input-file
#
# The input file will contain, on each line, a file name and an amount.
#


#
# What a poorly defined challenge.
#
# "You are given a file".
#
# What does that mean? Do we get the content? A file handle?
# A file descriptor? A file name?
#
# The example (but not the challenge itself), suggest we're getting
# a file name. Ok, but....:
#
# "moves the pointer"
#
# What pointer? File handles/descriptors point to something, so
# then it can be argued we should leave the file handle open, 
# pointing to a place in the file. But we have just established we
# are NOT GETTING a file handle -- we're getting a file name.
# So, what pointer are we talking about?
#
# What on earth are we supposed to do?
#
# Are we supposed to create a file handle, and keep file handle open?
# Should we just slurp in the file content, and keep a pointer
# to what we have returned?
#
# What should happen if we call 'readN' with different files, interleaved?
# Keep track of where we are for each file? Restart if called with file1,
# then file2, and then file1 again?
#
# What follows is a real stab in the dark -- I've no idea what
# we are supposed to do.
#

#
# Given a filename, read its contents if called for the first time with
# that filename. Return the next $amount of characters. (Or less if we
# have exhausted the content of the file).
#
sub readN ($filename, $amount) {
    state $cache;
    chomp ($$cache {$filename} //= do {local (@ARGV, $/) = $filename; <>});
    substr $$cache {$filename} => 0, $amount, ""
}

while (<STDIN>) {
    chomp;
    my ($filename, $amount) = split ' ';
    say readN $filename, $amount;
}

__END__
