#!/usr/bin/env perl
# Perl weekly challenge 187
# Task 1:  Days Together
#
# See https://wlmb.github.io/2022/10/17/PWC187/#task-1-days-together
use v5.36;
use List::Util qw(sum max min);
sub ddmm2days($x){
    state @month_lengths=qw(31 28 31 30 31 30 31 31 30 31 30 31);
    die "Wrong format: $x" unless $x=~/(\d\d)-(\d\d)/;
    my ($d,$m)=($1, $2);
    die "Wrong month: $m" unless 1<=$m<=12;
    die "Wrong day: $d. Only $month_lengths[$m-1] days in month $m"
        unless 1<=$d<=$month_lengths[$m-1];
    $d-1+sum @month_lengths[(0..$m-2)]
}
die <<"FIN" unless @ARGV==4;
Usage: $0 fs fe bs be
to obtain the number of days Foo and Bar are together,
where fs and fe are the start and end dates of Foo's holidays and
bs and be are the start and end dates of Bar's holidays. Dates are in the
format DD-MM.
FIN
my ($foo_start, $foo_end, $bar_start, $bar_end)=@ARGV;
my $days=  min(map {ddmm2days($_)} ($foo_end, $bar_end))
      - max(map {ddmm2days($_)}($foo_start, $bar_start));
$days=$days<0?0:1+$days;
say "Overlap between intervals ($foo_start, $foo_end) and ($bar_start, $bar_end) is $days days";
