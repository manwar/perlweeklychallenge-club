#!/usr/bin/perl

# Challenge 028

# Task #2
# Write a script to display Digital Clock. Feel free to be as creative as you
# can when displaying digits. We expect bare minimum something like "14:10:11".

use Modern::Perl;
use POSIX;
use Time::HiRes qw(usleep);

my %chars;

$chars{' '}[0] = "      ";
$chars{' '}[1] = "      ";
$chars{' '}[2] = "      ";
$chars{' '}[3] = "      ";
$chars{' '}[4] = "      ";

$chars{'0'}[0] = "  ___ ";
$chars{'0'}[1] = " |   |";
$chars{'0'}[2] = " |   |";
$chars{'0'}[3] = " |   |";
$chars{'0'}[4] = " |___|";

$chars{'1'}[0] = "      ";
$chars{'1'}[1] = "     |";
$chars{'1'}[2] = "     |";
$chars{'1'}[3] = "     |";
$chars{'1'}[4] = "     |";

$chars{'2'}[0] = "  ___ ";
$chars{'2'}[1] = "     |";
$chars{'2'}[2] = "  ___|";
$chars{'2'}[3] = " |    ";
$chars{'2'}[4] = " |___ ";

$chars{'3'}[0] = "  ___ ";
$chars{'3'}[1] = "     |";
$chars{'3'}[2] = "  ___|";
$chars{'3'}[3] = "     |";
$chars{'3'}[4] = "  ___|";

$chars{'4'}[0] = "      ";
$chars{'4'}[1] = " |   |";
$chars{'4'}[2] = " |___|";
$chars{'4'}[3] = "     |";
$chars{'4'}[4] = "     |";

$chars{'5'}[0] = "  ___ ";
$chars{'5'}[1] = " |    ";
$chars{'5'}[2] = " |___ ";
$chars{'5'}[3] = "     |";
$chars{'5'}[4] = "  ___|";

$chars{'6'}[0] = "  ___ ";
$chars{'6'}[1] = " |    ";
$chars{'6'}[2] = " |___ ";
$chars{'6'}[3] = " |   |";
$chars{'6'}[4] = " |___|";

$chars{'7'}[0] = "  ___ ";
$chars{'7'}[1] = "     |";
$chars{'7'}[2] = "     |";
$chars{'7'}[3] = "     |";
$chars{'7'}[4] = "     |";

$chars{'8'}[0] = "  ___ ";
$chars{'8'}[1] = " |   |";
$chars{'8'}[2] = " |___|";
$chars{'8'}[3] = " |   |";
$chars{'8'}[4] = " |___|";

$chars{'9'}[0] = "  ___ ";
$chars{'9'}[1] = " |   |";
$chars{'9'}[2] = " |___|";
$chars{'9'}[3] = "     |";
$chars{'9'}[4] = "     |";

$chars{':'}[0] = "      ";
$chars{':'}[1] = "      ";
$chars{':'}[2] = "   .  ";
$chars{':'}[3] = "   .  ";
$chars{':'}[4] = "      ";

my $CLEAR = "\e[H\e[2J";
my $HOME  = "\e[H";

sub banner {
    my($text) = @_;
    for my $row (0 .. $#{$chars{' '}}) {
        for my $c (split(//, $text)) {
            print $chars{$c}[$row];
        }
        print "\n";
    }
}

print $CLEAR;
while (1) {
    my $time = strftime("%H:%M:%S", localtime(time));
    print $HOME;
    banner($time);
    usleep(500*1000);
}
