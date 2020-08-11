#! /opt/local/bin/perl
#
#       counter.pl
#
#       PWC32 - 1
#           Count instances
#           Create a script that either reads standard input or one or more
#           files specified on the command-line. Count the number of times and
#           then print a summary, sorted by the count of each entry.
#
#           So with the following input in file example.txt
#
#               apple
#               banana
#               apple
#               cherry
#               cherry
#               apple
#           the script would display something like:
#
#               apple     3
#               cherry    2
#               banana    1
#           For extra credit, add a -csv option to your script, which would generate:
#
#               apple,3
#               cherry,2
#               banana,1
#
#
#       colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

my @args = @ARGV || './example.txt';    ## only so we can run it from the editor
my $counter = {};

if ( -f $args[0] ) {
## its a list of files
    for my $file ( @args ) {
        open (my $fh, "<", $file);
        my @lines = <$fh>;
        close $fh;

        for my $line ( @lines ){
            chomp $line;
            $counter->{$line}++;
        }
    }
}
else {
## it's just a STDIN list of words
    my @lines = @args;
    for my $line ( @lines ){
        chomp $line;
        $counter->{$line}++;
    }
}

for my $key (sort keys $counter->%*)    {
    printf "%-10s %-d\n", $key, $counter->{$key};

}


