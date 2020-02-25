#! /opt/local/bin/perl
#
#       source_dumper.pl
#
#       PWC 45 TASK #2
#       Source Dumper
#             Write a script that dumps its own source code. For example, say,
#             the script name is ch-2.pl then the following command should
#             returns nothing.
#
#                 $ perl ch-2.pl | diff - ch-2.pl
#
#       method: Perl, being an interpreted language, needs to know internally
#           the script file that it is being asked to execute. Thus we need only
#           find it, open it, read and print it.

#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

local $/ = undef;
open (my $fh, "<", $0) or die "can't open this script thats running this code to read: $0 : $!";
print <$fh>;

__DATA__

even prints the data section, see?


