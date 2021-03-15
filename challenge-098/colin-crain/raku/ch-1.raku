#!/usr/bin/env perl6
#
#
#       readin-ritin-and-random-characters.raku
#
#         TASK #1 › Read N-characters
#         Submitted by: Mohammad S Anwar
#         You are given file $FILE.
# 
#         Create subroutine readN($FILE, $number) returns the first n-characters
#         and moves the pointer to the (n+1)th character.
# 
#         Example:
#         Input: Suppose the file (input.txt) contains "1234567890"
#         Output:
#             print readN("input.txt", 4); # returns "1234"
#             print readN("input.txt", 4); # returns "5678"
#             print readN("input.txt", 4); # returns "90"
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Str $file = 'unicode-text-test.txt', Int $length = 20 ) ;

my $fh = open $file, :r;

## read first 20 chars
say readN($fh, $length);

## read next 40 chars starting at postion 21
say readN($fh, $length*2);

$fh.close;

sub readN( $fh, $length ) {
    my $out ~= $fh.getc for ^$length;
    return $out;
}
