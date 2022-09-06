#!/usr/bin/perl

=head1

Week 181:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-181

Task #2: Hot Day

    You are given file with daily temperature record in random order.

    Write a script to find out days hotter than previous day.

=cut

use v5.36;

my $IN = $ARGV[0];
open (my $FILE, "<", $IN) or die "$!\n";
my @data = <$FILE>;
close $FILE;

my %day_temp = map {
    chomp;
    my ($k, $v) = split /\,/;
    $k => $v+0;
} @data;

my $previous_day_temp;
foreach my $date (sort { $a cmp $b } keys %day_temp) {
    !defined $previous_day_temp
    and $previous_day_temp = $day_temp{$date}
    and next;
    if ($day_temp{$date} > $previous_day_temp) {
        say $date;
    }
    $previous_day_temp = $day_temp{$date};
}
