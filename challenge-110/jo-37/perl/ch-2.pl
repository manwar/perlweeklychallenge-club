#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental qw(signatures postderef);

our $examples;

run_tests() if $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [file ...]

-examples
    run the examples from the challenge
 
file ...
    file(s) to be transposed.  Multiple files are concatenated first,
    then transposed.

EOS


### Input and Output

{
    local $, = ',';
    # perlvar states:
    #   passing "\*ARGV" as a parameter to a function that expects a
    #   filehandle may not cause your function to automatically read the
    #   contents of all the files in @ARGV.
    # It seems to work, though.
    say @$_ for transpose_file(\*ARGV);
}


### Implementation

# Read lines from the given filehandle, split them at commas (chopping
# newlines) and push the parts onto a list of arrays.
sub transpose_file ($fh) {
    my @tr;
    while (<$fh>) {
        my @part = split /,|\n/;
        while (my ($i, $v) = each @part) {
            push $tr[$i]->@*, $v;
        }
    }

    @tr;
}


### Examples and tests

sub run_tests {
    open my $fh, '<', \(<<EOS =~ s/^ +//gmr);
        name,age,sex
        Mohammad,45,m
        Joe,20,m
        Julie,35,f
        Cristina,10,f
EOS
    is [transpose_file($fh)], [
        [qw(name Mohammad Joe Julie Cristina)],
        [qw(age 45 20 35 10)],
        [qw(sex m m f f)]], 'example';

    done_testing;
    exit;
}
