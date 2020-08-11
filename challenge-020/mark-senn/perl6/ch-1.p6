#
# Perl  Weekly  Challenge  - 020
# Task #1
#
# See
#      engineering.purdue.edu/~mark/pwc -020 -1. pdf
# for  more  information.

# Run  using  Perl v6.d.
use v6.d;

# See1
#      https :// docs.perl6.org/routine/MAIN
# for how to  define a MAIN  sub.   For  this  program , only
# a single  string  from  the  command  line  needs  to be
# accepted  with no  options  and the  following  will  suffice.
# This is nice  because  if I used a sub  MAIN here , I would
# put all of the  code  below  indented  inside  the sub  MAIN
# and  would  need to  reduce  the  font  size so it would  fit
# on the  page.
$_ = shift @*ARGS;

# The  Perl 6 regex
#     /((.){}$0 *)*/;
# with no  comments  could  be used.   For  this  regex I prefer
# commenting  it like  below  to  explain  it to  people  who may
# have  not  used  regexes  before.

# Search  for the  quoted  comments  in the  code  below  in3
#      https :// docs.perl6.org/language/regexes
# for  more  information.
/                 # Start a Perl 6 regex (called "regular  expression" in Perl  5).
    (                 # Start a group  to match a string  of  identical  characters.
        (.)           # Match a single  character.
        {}            # "This  code  block  publishes  the  capture  inside  the
                      # regex , so that it can be  assigned  to other  variables
                      # or used  for  subsequent  matches ."
        $0*           # Match  the  previously  matched  character
                      # zero or more  times.
    )*            # End  the  group  to match a string  of  identical  characters.
                  # There  are  zero or more  groups  of  identical  characters.
/;                # End  the  Perl 6 regex.

# "Coercing  the  match  object  to a list  gives  an easy  way
# to  programmatically  access  all  elements :"
say$/.list.join;
