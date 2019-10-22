# https://perlweeklychallenge.org/blog/perl-weekly-challenge-030/
# Task #1
# Write a script to list dates for Sunday Christmas between 2019 and 2100.
# For example, 25 Dec 2022 is Sunday.
perl -mDateTime -e 'do { print $_.$/ if DateTime->new( year => $_, month => 12, day => 25 )->dow == 7 } for ( 2019 .. 2100 );'
