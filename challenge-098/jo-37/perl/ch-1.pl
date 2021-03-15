#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use warnings FATAL => 'all';
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;    # does not return

die <<EOS unless @ARGV > 1;
usage: $0 [-examples] [-tests] [file1 c11... fileN cN1...]

-examples
    run examples from the challenge

-tests
    run some tests

fileX (not numeric)
    select file for following read operation(s)

cij (numeric)
    number of characters to read from selected file

Operations on different files may be interleaved.  The file position is
kept separately for each filename.

Example:

ch-1_A.txt: 1234567890
ch-1_B.txt: abcdefghij

./ch-1.pl ch-1_A.txt 4 3 ch-1_B.txt 1 2 ch-1_A.txt 2 1 ch-1_B.txt 3 4

Output:
1234
567
a
bc
89
0
def
ghij

EOS


### Input and Output

binmode STDOUT, ':utf8';

/^\d+$/ and say readN($a, $_) or $a = $_ for @ARGV;


### Implementation

# Read up to $n characters from named file at current position.  Will
# start over from the beginning after eof was detected for the named
# file.
sub readN ($file, $n) {

    # Track filehandles for named files.
    state %fh;

    # Open filehandle for reading characters, not bytes.
    open $fh{$file}, '<:encoding(utf8)', $file or die "$file: $!"
        unless $fh{$file};

    my $nchar = read $fh{$file}, (my $read), $n;
    die "$file: $!" unless defined $nchar;

    # Close filehandle if eof was detected.
    delete $fh{$file} if $nchar < $n;

    $read;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip 'examples' unless $examples;
        is readN('ch-1_A.txt', 4), '1234', 'example: first chunk';
        is readN('ch-1_A.txt', 4), '5678', 'example: second chunk';
        is readN('ch-1_A.txt', 4), '90', 'example: third chunk';
    }

    SKIP: {
        skip 'tests' unless $tests;
        is readN('ch-1_A.txt', 10), '1234567890', 'read all';
        is readN('ch-1_A.txt', 1), '', 'at eof';
        is readN('ch-1_A.txt', 1), '1', 'file reopened';
        ok readN('ch-1_A.txt', 10), 'seek eof';
        is readN('ch-1_A.txt', 11), '1234567890', 'read all, hit eof';
        is readN('ch-1_A.txt', 1), '1', 'file reopened';
        is readN('ch-1_C.txt', 3), 'Bär', 'multibyte character';
    }

    done_testing;
    exit;
}
