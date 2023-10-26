#! /usr/bin/env perl

die "At least 2 elements required" unless @ARGV > 1;

my $chk     = shift(@ARGV);
my @str     = @ARGV;
my $acronym = "";

for my $str (@str)
{
  $acronym .= lc(substr($str,0,1));
}

$acronym eq lc($chk)
  ? print "true\n"
  : print "false\n";
