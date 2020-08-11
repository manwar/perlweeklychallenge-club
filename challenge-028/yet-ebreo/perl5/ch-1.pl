# Write a script to check the file content without actually reading the content.
# It should accept file name with path as command line argument and 
# print “The file content is binary.” or else “The file content is ascii.” accordingly.
use strict;
use warnings;
use v5.10;

die "Usage\n\tch-1.pl <file>..<file_n>\n\n" if @ARGV<1;
for (@ARGV) {
    if (-f $_ && -e _ && -r _) {
        if (-T $_) {
            say "[$_]: The file content is ascii.";        
        } else {
            say "[$_]: The file content is binary.";
        }
    }
}