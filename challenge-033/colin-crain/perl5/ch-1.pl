#! /opt/local/bin/perl
#
#       count_letters.pl
#
#       PWC33 - Task #1
#           Count Letters (A..Z)
#           Create a script that accepts one or more files specified on the
#           command-line and count the number of times letters appeared in the
#           files.
#
#           So with the following input file sample.txt
#
#               The quick brown fox jumps over the lazy dog.
#
#           the script would display something like:
#
#               a: 1
#               b: 1
#               c: 1
#               d: 1
#               e: 3
#               f: 1
#               g: 1
#               h: 2
#               i: 1
#               j: 1
#               k: 1
#               l: 1
#               m: 1
#               n: 1
#               o: 4
#               p: 1
#               q: 1
#               r: 2
#               s: 1
#               t: 2
#               u: 2
#               v: 1
#               w: 1
#               x: 1
#               y: 1
#               z: 1
#
#       method: the main points of interest here are the local setting of $/,
#           the input record separator, to undef so on reading the entire
#           file will get slurped up in one go. After that the slurped file
#           is quickly reduced to an array-shaped pile of letters by the awesome
#           power of the
#
#               grep {/[a-z]/} split //, lc()
#
#           combination. This is then iterated through with each letter
#           occurance incrementing a hash value. The resultant hash is then
#           sorted and displayed.
#
#       colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

my @args = @ARGV;
my $counter = {};

for my $file ( @args ) {
    if (! -f $file) { die "argument $file is not a valid file "};
    open (my $fh, "<", $file) || die;  { "file read error: \'$file\' cannot be opened" };
    local $/ = undef;       ## locally set the line separator to undef so we slurp the entire file
    my $text = <$fh>;
    close $fh;

    my @letters = grep {/[a-z]/} split //, lc($text);
    for my $letter ( @letters ){
        $counter->{$letter}++;
    }
}

## output the hash
for my $key (sort keys $counter->%*)    {
    printf "%3s: %-d\n", $key, $counter->{$key};

}
