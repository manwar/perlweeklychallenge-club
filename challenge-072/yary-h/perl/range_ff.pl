#!/usr/bin/env perl -n

# Run as:
# range.pl 4 10 < input.txt
# or
# range.pl 4 10 input.txt

# This version abuses command-line option in shebang,
# and also the flip-flop

our ($begin_line, $end_line);
BEGIN { ($begin_line, $end_line)=splice @ARGV,0,2 };

$. == $begin_line .. print && $. >= $end_line && exit
