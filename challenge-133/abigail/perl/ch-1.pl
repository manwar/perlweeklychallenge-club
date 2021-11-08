#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# Run as: perl ch-1.pl < input-file
#

#
# The challenge says:
#
#    Please avoid using built-in function.
#
# That makes if very hard to do anything in Perl. There is the sqrtint
# function in Math::Prime::Utils which does exactly what is asked (and
# which obviously isn't a build-in), but that just returns a value.
# To print the result, one would need print or say (or (sys)write),
# but those are build-in functions as well.
#
# So, the solution we opted for is to branch out to AWK. Now, we cannot
# use "exec" or "system" to call an AWK program, as both "exec" and
# "system" are build-ins. Hence, we use backticks. But there is a catch,
# backticks collect the output of the executed program. And we cannot
# use print or say to print the return value of the backticks as explained
# above. Therefore, we let the AWK program write its output to the terminal.
#
# There's one remaining snag we need to cover. When reading in a number,
# it will have a trailing newline. AWK considers newlines to be statement
# terminators (hurray for AWK), so we either have to escape the newline,
# or get rid of it. Using chomp or chop is out, as they are build ins,
# so we use s/[^0-9]+//gr to get rid of any non digits.
#

`awk 'BEGIN {print (int (sqrt (${\s/[^0-9]+//gr}))) > "/dev/tty"}'` for <>;

