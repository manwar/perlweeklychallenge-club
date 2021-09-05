#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

use FindBin;
use IPC::Open2;

#
# See ../README.md
#

#
# Run as: perl ch-1.pl < input-file
#

#
# This is almost exactly the same as week 87, part 1, with two, trivial,
# differences:
#
#   - In week 087, we wanted the largest rectangle containing 1s
#     instead of 0s.
#   - In week 087, a largest rectangle of '1x1' didn't count, 
#     and a 0 needed to be printed instead.
#

#
# So, we will "solve" is challenge by just calling the solution
# of week 87, with some pre and post processing of the input
# and output:
#
#   - We will swap the 0s and 1s in the input.
#   - We'll replace any 1s in the output with 0s. (If the largest
#     rectangle is a 1x1 rectangle, week 87 would return a 0 -- which
#     *IS* a 1x1 rectangle...)
#

#
# Note also that the first example is a bit misleading. It says the
# largest sub-matrix is:
#
#         0 0 0
#         0 0 0
#
# But that's only one of the largest. There is an equally large rectangle
# shaped like this:
#
#         0 0
#         0 0
#         0 0
#
# (Someone really should start proofreading those challenges)
#

my $program = "$FindBin::Bin/../../../challenge-087/abigail/perl/ch-2.pl";

my $pid = open2 (my $out, my $in, $^X, $program) // die "open failed: $!";

print $in y/01/10/r while <>;

close $in;

print y/1/0/r while <$out>;

waitpid ($pid, 0);

__END__
