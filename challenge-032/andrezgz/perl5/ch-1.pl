#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-032/
# Task #1
# Count instances
# Create a script that either reads standard input or one or more files specified on the command-line.
# Count the number of times and then print a summary, sorted by the count of each entry.
# So with the following input in file example.txt
# apple
# banana
# apple
# cherry
# cherry
# apple
# the script would display something like:
# apple     3
# cherry    2
# banana    1
# For extra credit, add a -csv option to your script, which would generate:
# apple,3
# cherry,2
# banana,1

use strict;
use warnings;

my $csv = @ARGV && $ARGV[0] eq '-csv' ? 1 : 0;
shift @ARGV if $csv;

print "Ctrl + D to finish\n" unless @ARGV; # when entering input from STDIN

my %entries;
chomp, $entries{$_}++ while (<>); # count instances

print "Instances count:\n";
print join "\n",                                        # Print a line
      map  { sprintf '%s%s%d',                          # composed by
              $_,                                       # the entry name,
              $csv ? ',' : "\t",                        # the separator (comma or tab),
              $entries{$_}                              # and the number of instances
           }
      reverse sort { $entries{$a} <=> $entries{$b} }    # from the sorted by number of instances (desc)
      keys %entries;                                    # entry list

print "\n";

__END__
 ./ch-1.pl
Ctrl + D to finish
apple
cherry
apple
Instances count:
apple   2
cherry  1

./ch-1.pl w1.txt
Instances count:
apple   3
cherry  2
banana  1

./ch-1.pl -csv example.txt
Instances count:
apple,3
cherry,2
banana,1
