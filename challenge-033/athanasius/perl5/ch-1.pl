#!perl

################################################################################
=comment

Perl Weekly Challenge 033
=========================

Task #1
-------
*Count Letters (A..Z)*

Create a script that accepts one or more files specified on the command-line and
count the number of times letters appeared in the files.

So with the following input file sample.txt

  The quick brown fox jumps over the lazy dog.

the script would display something like:

a: 1
b: 1
c: 1
d: 1
e: 3
f: 1
g: 1
h: 2
i: 1
j: 1
k: 1
l: 1
m: 1
n: 1
o: 4
p: 1
q: 1
r: 2
s: 1
t: 2
u: 2
v: 1
w: 1
x: 1
y: 1
z: 1

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Getopt::Long;

const my $USAGE => "USAGE: perl $0 <Str>...     Name(s) of file(s) "           .
                                               "containing text data\n"        .
         "Options:\n"                                                          .
   "       --count                   Order by letter counts (highest first)\n" .
   "       --help                    Print usage details and exit\n";

BEGIN
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my ($count, $help);

    GetOptions
    (
        count => \$count,
        help  => \$help,

    ) or die $USAGE;

    die $USAGE if $help || @ARGV == 0;

    my $counts  = read_data();
    my $sort_by = $count ?
         sub ($$) { $counts->{$_[1]} <=> $counts->{$_[0]} || $_[0] cmp $_[1] } :
         sub ($$) { $_[0] cmp $_[1] };

    printf "%s: %d\n", $_, $counts->{ $_ } for sort $sort_by keys %$counts;
}

#-------------------------------------------------------------------------------
sub read_data
#-------------------------------------------------------------------------------
{
    my %counts;

    for my $filename (@ARGV)
    {
        open my $fh, '<', $filename
            or die "Cannot open file '$filename' for reading, stopped";

        while (my $line = <$fh>)
        {
            ++$counts{ lc $_ } for grep { /[a-z]/i } split //, $line;
        }

        close $fh
            or die "Cannot close file '$filename', stopped";
    }

    return \%counts;
}

################################################################################
