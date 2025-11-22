#! /usr/bin/env raku

subset HHMM where * ~~ /^ <[012]><[0..9]> ":" <[0..5]><[0..9]> $/;

unit sub MAIN (HHMM $source, HHMM $target,
               :v(:$verbose));

my ($source-h, $source-m) = $source.split(":");
my ($target-h, $target-m) = $target.split(":");

my $source-minutes = $source-h * 60 + $source-m;
my $target-minutes = $target-h * 60 + $target-m;

die "Source > 23:59" if $source-minutes > 1439;
die "Target > 23:59" if $target-minutes > 1439;

my $delta = $target-minutes - $source-minutes;

$delta += 60 * 24 if $delta < 0;

my @polymod = $delta.polymod(5, 3, 4);

if $verbose
{
  say ": Source $source = $source-minutes min past midnight";
  say ": Target $target = $target-minutes min past midnight";
  say ": Target is the next day, adding 24x60 min = { $target-minutes + 60*24 } min" if $target-minutes - $source-minutes < 0;
  say ": Delta $delta min";
  say ": Add @polymod[0]x 1 min";
  say ": Add @polymod[1]x 5 min";
  say ": Add @polymod[2]x 15 min";
  say ": Add @polymod[3]x 60 min";
}

say @polymod.sum;
