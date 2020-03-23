#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';

# Write a script to accept an integer 1 <= N <= 5 that would print all possible strings of size N formed by using only vowels (a, e, i, o, u).
# The string should follow the following rules:
# ‘a’ can only be followed by ‘e’ and ‘i’.
# ‘e’ can only be followed by ‘i’.
# ‘i’ can only be followed by ‘a’, ‘e’, ‘o’, and ‘u’.
# ‘o’ can only be followed by ‘a’ and ‘u’.
# ‘u’ can only be followed by ‘o’ and ‘e’.
# For example, if the given integer N = 2 then script should print the following strings:
# ae
# ai
# ei
# ia
# io
# iu
# ie
# oa
# ou
# uo
# ue

#One liner solution. I believe the conditions can be simplified, but I decided to keep it this way so that it 
#Clearly reflects the conditions mentioned in the task description
!(/a[^ei]/ || /e[^i]/ || /i[^aeou]/ || /o[^au]/ || /u[^oe]/) && say for glob "{a,e,i,o,u}" x ($ARGV[0]||1);
=begin
perl .\ch-2.pl 3
aei
aia
aie
aio
aiu
eia
eie
eio
eiu
iae
iai
iei
ioa
iou
iue
iuo
oae
oai
oue
ouo
uei
uoa
uou
=cut