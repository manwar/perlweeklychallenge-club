#!/usr/bin/env sh --

###########################################################################
# script name: ch-1.sh                                                    #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-049/         #
#                                                                         #
# Smallest Multiple                                                       #
# Write a script to accept a positive number as command line argument     #
# and print the smallest multiple of the given number consists of digits  #
# 0 and 1.                                                                #
#                                                                         #
###########################################################################

# This short one works, but . . . 
#perl -e'$a='$1';$a+='$1'while$a=~/[^01]/;print$a,$/' 

perl -e 'my $a = $ARGV[0]; my $b = $a; $a += $b while $a =~ /[^01]/; print"$a\n"' $1
