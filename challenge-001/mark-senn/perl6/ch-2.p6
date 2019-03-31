#
# Retrieved from
#     https://perlweeklychallenge.org/blog/a-new-week-a-new-challenge
# on 2019-03-27 at 11:28 -04:
#
#     Challenge #2
#
#     Write one-liner to solve FizzBuzz problem and print number 1-20.
#     However, any number divisible by 3 should be replaced by the
#     word fizz and any divisible by 5 by the word buzz. Numbers
#     divisible by both become fizz buzz.
#
# Since we are not playing Perl Golf I'm going to concentrate on making
# the code understandable.
#
# The
#     Numbers divisible by both become fizz buzz.
# condition would make this a complicated structure of if statements.  It
# might be easier for people to understand if a
#     (conndition)  and  print "...";
# construct was used instead.  This will make it easier to add conditions
# like if divisible by 3, 5, and 7 print "fizz buzz baz".  "If" statements
# are hard enough to read when formatted in two dimensions---they're
# even worse when typeset in one dimension.  (I am assuming the one-liner
# must be one physical line---not one logical line.)
#
# We could use
#     perl6 -e '(1..20).map({  my $t="";  my $e3 = $_ %% 3;  my $e5 = $_ %% 5;  $e3 and $t~="fizz";  $e3 && $e5 and $t~=" ";  $e5 and $t~="buzz";  !$e3 && !$e5 and $t~=$_;    say $t;})'
#
# Using "for" instead of "map" will be understood by people that don't
# already know about "map" and the "{...}" needed inside of it.  Put
# two spaces around each statement in the for body to make it easier to read.
#     perl6 -e 'for (1..20) {  my $t="";  my $e3 = $_ %% 3;  my $e5 = $_ %% 5;  $e3 and $t~="fizz";  $e3 && $e5 and $t~=" ";  $e5 and $t~="buzz";  !$e3 && !$e5 and $t~=$_;  say $t;}'
#
# Instead of building the string in $t and printing it at the end of
# the loop we can make this more clear by doing print statements as we go.
# For uniformity use only "print" instead of a combination of "print" and
# "say".  Multi-line commented version:
#     for (1..20)
#     {
#         # Is $_ evenly divisible by 3?
#         my $e3 = $_ %% 3;
#         # Is $_ evenly divisible by 5?
#         my $e5 = $_ %% 5;
#         $e3           and  print "fizz";
#         $e3 && $e5    and  print " ";
#         $e5           and  print "buzz";
#         !$e3 && !$e5  and  print $_;
#         print "\n";
#     }
#

perl6 -e 'for (1..20) {  my $e3 = $_ %% 3;  my $e5 = $_ %% 5;  $e3 and print "fizz";  $e3 && $e5 and print " ";  $e5 and print "buzz";  !$e3 && !$e5 and print $_;  print "\n";  }'

#===SORRY!=== Error while compiling /home/manwar/github/perlweeklychallenge-club/challenge-001/mark-senn/perl6/ch-2.p6
#Two terms in a row
#at /home/manwar/github/perlweeklychallenge-club/challenge-001/mark-senn/perl6/ch-2.p6:53
#------> perl6 -e⏏ 'for (1..20) {  my $e3 = $_ %% 3;  my $
#    expecting any of:
#            infix
#            infix stopper
#            postfix
#            statement end
#            statement modifier
#            statement modifier loop

