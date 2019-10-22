# https://perlweeklychallenge.org/blog/perl-weekly-challenge-026/
# Task #1
# Create a script that accepts two strings, let us call it,
# "stones" and "jewels". It should print the count of "alphabet"
# from the string "stones" found in the string "jewels".
# For example, if your stones is "chancellor" and "jewels" is "chocolate",
# then the script should print "8". To keep it simple,
# only A-Z,a-z characters are acceptable.
# Also make the comparison case sensitive.
perl -e 'print scalar grep {$_ =~ /[A-Za-z]/ && index($ARGV[1], $_) != -1} split //, $ARGV[0];' $1 $2
