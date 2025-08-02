# The Weekly Challenge 273
# Task 1 Percentage of Character
use v5.30.0;
use warnings;
use Math::Round qw/round/;

sub sc {
    my $str = $_[0];
    my $char = $_[1];
    my $per = (grep {$_ eq $char} split "", $str) / length $str;
    return round(100*$per);
}

use Test::More tests=>6;
ok sc("perl", "e") == 25;
ok sc("java", "a") == 50;
ok sc("python", "m") == 0;
ok sc("ada", "a") == 67;
ok sc("ballerina", "l") == 22;
ok sc("analitik", "k") == 13;
