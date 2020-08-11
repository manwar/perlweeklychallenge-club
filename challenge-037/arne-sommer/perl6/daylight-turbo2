#! /usr/bin/env raku

use LWP::Simple;

unit sub MAIN (*@citymapping, :$left = "London:2019:11", :$right = "London:2019:12");

my $base-url = 'https://www.timeanddate.com/sun/';

my @months   = ('', 'January', 'February', 'March', 'April', 'May', 'June', 'July',
                    'August', 'September', 'October', 'November', 'December');

my %city2url = (
		 Berlin     => 'germany/berlin',
		 Birmingham => 'uk/birmingham',
		 Edinburgh  => 'uk/edinburgh',
                 London     => 'uk/london',
                 Manchester => 'uk/manchester',
		'New York'  => 'usa/new-york',
		 Oslo       => 'norway/oslo',
		 Paris      => 'france/paris',
                 Sydney     => 'australia/sydney',
               );

if @citymapping
{
  for @citymapping -> $line
  {
    my ($city, $url) = $line.split(":");
    %city2url{$city} = $url;
  }
}

my %data;

read-data($left);
read-data($right);

sub read-data ($city-month)
{
  my $line;

  my ($city, $year, $month) = $city-month.split(':');

  die "Illegal month \"$month\" (use 01..12)" unless $month eq one <01 02 03 04 05 06 07 08 09 10 11 12>;
  die "Illegal year \"$year\" (use 1900..2199)" unless 1900 <= $year.Int <= 2199;
  die "City '$city' not supported. Use one of { %city2url.keys.sort }." unless %city2url{$city};

  if "$city-month.html".IO.e
  {
    $line = slurp "$city-month.html";
  }
  else
  {
    my $url = $base-url ~ %city2url{$city} ~ "?month=" ~ $month ~ "&year=" ~ $year;

    $line = LWP::Simple.get($url).lines.join("\n");

    spurt "$city-month.html", $line;
  }

  $line ~~ /\<tbody\>(.*?)\<\/tbody\>/;

  for $0.Str.split("</tr>") -> $line
  {
    $line ~~ /data\-day\=(\d+) \s .*? \"c \s tr \s sep\-l\"\>(\d+\:\d+\:\d+)\<\/td\>/;

    next unless $0;

    %data{$city-month}{$0.Str} = $1.Str;
  }
}

my ($left-city,  $left-year,  $left-month)  = $left.split(':');
my ($right-city, $right-year, $right-month) = $right.split(':');


say "    { $left-city.fmt('%8s') }   { $right-city.fmt('%8s') }";
say "Day { @months[$left-month].fmt('%8s') }   { @months[$right-month].fmt('%8s') }   Difference";
say "    { $left-year.fmt('%8s')}   { $right-year.fmt('%8s') }";

for 1..31 -> $day
{ 
  my $left-value  = %data{$left}{$day};
  my $right-value = %data{$right}{$day};

  ! $left-value && ! $right-value && last;

  print $day.fmt('%2d') ~ ' ';

  print $left-value
    ?? $left-value.fmt('%9s') ~ '  '
    !! ' ' x 11;
 
  print $right-value
   ?? $right-value.fmt('%9s') ~ '  '
   !! ' ' x 11;

  print "{ (s2hms( hms2s($right-value) - hms2s($left-value))).fmt('%10s') }" if $left-value && $right-value;
  say '';
}

sub hms2s ($hms)
{
  my @parts = $hms.split(':') // return 0;
  return @parts[0] * 60 * 60 + @parts[1] * 60 + @parts[2];
}

sub s2hms ($s is copy)
{
  my $sign = "";
  if $s < 0 { $s = -$s; $sign = "-"; } 
  
  my $h = $s div 3600; $s -=  $h * 3600;
  my $m = $s div   60; $s -=  $m *   60;

  return "$sign$h:{ $m.fmt('%02d') }:{ $s.fmt('%02d') }" if $h;
  return "$sign$m:{ $s.fmt('%02d') }" if $s;
  return "$sign$s";
}
