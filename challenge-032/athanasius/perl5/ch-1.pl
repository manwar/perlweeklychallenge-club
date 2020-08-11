#!perl

################################################################################
=comment

Perl Weekly Challenge 032
=========================

Task #1
-------
Contributed by Neil Bowers

Count instances

Create a script that either reads standard input or one or more files specified
on the command-line. Count the number of times and then print a summary, sorted
by the count of each entry.

So with the following input in file example.txt

  apple
  banana
  apple
  cherry
  cherry
  apple

the script would display something like:

  apple     3
  cherry    2
  banana    1

For extra credit, add a -csv option to your script, which would generate:

  apple,3
  cherry,2
  banana,1

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

# Assumption: Data is to be treated as case-sensitive

use strict;
use warnings;
use Const::Fast;
use Getopt::Long;

const my $USAGE =>
         "USAGE: perl $0                  Read from standard input\n"      .
         "       perl $0 --file <Str>...  Read from file(s)\n"             .
         "       perl $0 <Str>...         Read from the command line\n\n"  .
         "Options:\n"                                                      .
    "       --csv                         Generate output in CSV format\n" .
    "       --help                        Print usage details and exit\n";

BEGIN
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my ($csv, $data, $help) = read_data();

    if ($help)
    {
        print $USAGE;
    }
    else
    {
        # Count the entries

        my %count;
         ++$count{$_} for @$data;

        # Sort keys by count: highest count first, equal counts in lexicographi-
        # cal order. Adapted from:
        #   https://perldoc.perl.org/5.30.0/perlfaq4.html#How-do-I-sort-a-hash-
        #           (optionally-by-value-instead-of-key)%3f

        my @keys = sort
                   {
                       $count{$b} <=> $count{$a}    # Descending
                       ||
                       $a cmp $b                    # Lexicographical

                   } keys %count;

        my $delimiter = $csv ? ',' : "\t";

        printf "%s%s%d\n", $_, $delimiter, $count{$_} for @keys;
    }
}

#-------------------------------------------------------------------------------
sub read_data
#-------------------------------------------------------------------------------
{
    my ($csv, $data, @files, $help);

    GetOptions
    (
         csv         => \$csv,
        'file=s{1,}' => \@files,
         help        => \$help,

    ) or die $USAGE;

    unless ($help)
    {
        if    (scalar @files > 0)
        {
            $data = read_files(@files);
        }
        elsif (scalar @ARGV  > 0)
        {
            $data = [ @ARGV ];
        }
        else
        {
            printf "Enter data (^%s to stop):\n", $^O eq 'MSWin32' ? 'Z' : 'D';

            push @$data, split /\s+/ while <STDIN>;
        }
    }

    return ($csv, $data, $help);
}

#-------------------------------------------------------------------------------
sub read_files
#-------------------------------------------------------------------------------
{
    my @data;
    my @files = @_;

    for my $file (@files)
    {
        my $text = '';

        open my $fh, '<', $file
            or die "Cannot open file '$file' for reading, stopped";

        {
            local $/;
            $text = <$fh>;
        }

        close $fh
            or die "Cannot close file '$file', stopped";

        push @data, split /\s+/, $text;
    }

    return \@data;
}

################################################################################
