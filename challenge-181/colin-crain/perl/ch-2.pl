#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       hot-hot-hot.pl
#
#       Hot Day
#         Submitted by: Mohammad S Anwar
#         You are given file with daily temperature record in random order.
# 
#         Write a script to find out days hotter than previous day.
# 
#         Example
#         Input File: (temperature.txt)
# 
#         2022-08-01, 20
#         2022-08-09, 10
#         2022-08-03, 19
#         2022-08-06, 24
#         2022-08-05, 22
#         2022-08-10, 28
#         2022-08-07, 20
#         2022-08-04, 18
#         2022-08-08, 21
#         2022-08-02, 25
# 
#         Output:
#         2022-08-02
#         2022-08-05
#         2022-08-06
#         2022-08-08
#         2022-08-10

#       notes: 
#         we will assume the previous day to mean the most-recently 
#         previously recorded day, should there be any gaps.
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


my $infile = shift // './temperature.txt';

open( my $fh, '<', $infile) or die "can't open input file $infile: $!";

my @lines = <$fh>;

@lines = sort { $a->[0] cmp $b->[0] } map { chomp; [ split /, /, $_ ] } @lines;

my $temp = $lines[0]->[1];
for (@lines) {
    say $_->[0] if $_->[1] > $temp;
    $temp = $_->[1];
}














# use Test::More;
# 
# is 
# 
# done_testing();
