use v6;

#       ch-1.p6
#
#       PWC 40 - TASK #1
#       Show multiple arrays content
#           You are given two or more arrays. Write a script to display values of each list at a given index.
#
#           For example:
#
#               Array 1: [ I L O V E Y O U ]
#               Array 2: [ 2 4 0 3 2 0 1 9 ]
#               Array 3: [ ! ? £ $ % ^ & * ]
#           We expect the following output:
#
#               I 2 !
#               L 4 ?
#               O 0 £
#               V 3 $
#               E 2 %
#               Y 0 ^
#               O 1 &
#               U 9 *
#
#       method: there's more than one way to do it, of course. In Raku there's even a
#           choice of built-in zip operators available, the function zip() and
#           the infix Z metaoperator. The Z metaoperator can be used here without its
#           metaprocessing ability, which isn't necessary to just gather the
#           elements. An example of the metaoperator, zipping (Z) with string
#           concatenation (~) -> (Z~) is given as well. Note this makes a new string
#           rather than a list.
#
#       2019 colin crain
#
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

my @a = <I L O V E Y O U>;
my @b = 2, 4, 0, 3, 2, 0, 1, 9;
my @c = <! ? £ $ % ^ & *>;


my @zipzip    = zip @a, @b, @c;
my @zipZ      = @a Z @b Z @c;
my @zipConcat = @a Z~ @b Z~ @c;


for @zipzip -> @list {
    say join ' ', @list;
}
say '=' x 25;

for @zipZ   -> @list {
    say join ' ', @list;
}
say '=' x 25;

$_.say for @zipConcat;
