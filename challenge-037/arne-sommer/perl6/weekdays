#! /usr/bin/env raku

unit sub MAIN (Int $year = 2019, Bool :$sum);

my @day-count;
my @month-name = ("", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
my $date = Date.new($year, 1, 1); 

while $date.year == $year
{
  @day-count[$date.month]++ if $date.day-of-week <= 5;
  $date.=later(days => 1);
}

say "Year: $year" unless $year == 2019;
say "@month-name[$_]: @day-count[$_] days" for 1 .. 12;
say "Total: { @day-count.sum}" if $sum;