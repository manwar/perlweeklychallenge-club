use v6;

################################################################################
=begin comment

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

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

# Assumption: Data is to be treated as case-sensitive

BEGIN say '';

#===============================================================================
sub MAIN
(
          **@args,              #= File name(s) OR data word(s) OR none (to read
                                #= from stdin)
    Bool:D :$csv  = False,      #= Generate output in CSV format
    Bool:D :$help = False,      #= Print usage details and exit
)
#===============================================================================
{
    if $help
    {
        $*USAGE.say;
    }
    else
    {
        my Str @strs = @args;
        my Str @data = read-data(@strs);

        # Count the entries

        my UInt %count;
        ++%count{$_} for @data;

        # Sort keys by count: highest count first, equal counts in lexicographi-
        # cal order. Adapted from:
        #   https://perldoc.perl.org/5.30.0/perlfaq4.html#How-do-I-sort-a-hash-
        #           (optionally-by-value-instead-of-key)%3f

        my Str @keys = %count.keys.sort:
                       {
                           %count{$^b} <=> %count{$^a}      # Descending
                           ||
                           $^a cmp $^b                      # Lexicographical
                       };

        my Str $delimiter = $csv ?? ',' !! "\t";

        "%s%s%d\n".printf: $_, $delimiter, %count{$_} for @keys;
    }
}

#-------------------------------------------------------------------------------
sub read-data(Str:D @args --> Array[Str])
#-------------------------------------------------------------------------------
{
    my Str @data;

    if @args.elems > 0
    {
        for @args -> Str $arg
        {
            if $arg.IO.e
            {
                @data.push: $_ for $arg.IO.slurp.words;
            }
            else
            {
                @data.push: $arg;
            }
        }
    }
    else    # Read data from standard input
    {
        "Enter data (^%s to stop):\n".printf: $*KERNEL eq 'win32' ?? 'Z' !! 'D';

        @data = $*IN.words;
    }

    return @data;
}

################################################################################
