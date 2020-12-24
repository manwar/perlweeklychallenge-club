#! /opt/local/bin/perl5.26
#
#       number-speak.pl
#
#       TASK #1 › Count Number
#         Submitted by: Mohammad S Anwar
#         You are given a positive number $N.
#
#         Write a script to count number and display as you read it.
#
#         Example 1:
#             Input: $N = 1122234
#             Output:   21321314
#             (as we read "two 1 three 2 one 3 one 4")
#
#         Example 2:
#             Input: $N = 2333445
#             Output: 12332415
#
#             (as we read "one 2 three 3 two 4 one 5")
#
#          Example 3:
#             Input: $N = 12345
#             Output: 1112131415
#
#             (as we read "one 1 one 2 one 3 one 4 one 5")
#
#         method:
#             the puzzle here is to count the instances of a given
#             digit as we read the number. The count starts at 1, and
#             if the next number is the same as the previous, the
#             count is incremented.
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:


my  $num = shift @ARGV // '12227786622222222222222222222222222222';

## mention our input
say "input:               ",$num;

## split and count...
say "numerically          ", speak_number( $num );

## ...using regex...
say "now using a regex:         ",
    join '', map { length($_), substr($_,0,1) } $num =~ m/1+|2+|3+|4+|5+|6+|7+|8+|9+|0+/g;

## ...and spoken
say "now as she is spoke: ", speak_english( $num );


## ## ## ## ## SUBS:

sub speak_number {
    my ($current, @digits)  = split //, shift;
    my $count = 1;
    my $output = '';

    for (@digits) {
        ($count++, next) if ($_ == $current);
        $output .= $count . $current;
        ($current, $count) = ($_, 1);
    }

    return $output . $count . $current;

}

sub speak_english {
    use Lingua::EN::Inflexion;
    my ($current, @digits)  = split //, shift;
    my $count = 1;
    my @output;
    my $mult = 0;
    my %cardinal = (    1 => 'ones',
                        2 => 'twos',
                        3 => 'threes',
                        4 => 'fours',
                        5 => 'fives',
                        6 => 'sixes',
                        7 => 'sevens',
                        8 => 'eights',
                        9 => 'nines',
                        0 => 'zeros'  );

    for (@digits) {
        ($count++, next) if ($_ == $current);
        my $exp = inflect("<#nfw300:$count> <N:$cardinal{$current}>");
        push @output, $exp;
        ($current, $count) = ($_, 1);
        $mult = 1;
    }

    my $str = (join ', ', @output) . ($mult? " and " : "");
    return q(") . "\u$str" . inflect("<#nw300:$count> <N:$cardinal{$current}>") . q(.");

}



# say "\n-----------------------------------\n";
#
# use Test::More;
#
# is speak_number(1122234), 21321314,     'Ex 1';
# is speak_number(2333445), 12332415,     'Ex 2';
# is speak_number(12345),   1112131415,   'Ex 3';
# is speak_number(99968882222),   39163842,   'Ex I just made up ';
#
#
# done_testing();
