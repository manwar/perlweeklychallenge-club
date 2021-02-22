#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;
use Fcntl qw< O_RDONLY SEEK_SET >;

sub readN ($FILE, $number) {
   state $at = {};
   sysopen my $fh, $FILE, O_RDONLY or die "sysopen('$FILE'): $!\n";
   sysseek $fh, $at->{$FILE} // 0, SEEK_SET;
   my $retval = '';
   my $n = sysread $fh, $retval, $number;
   close $fh or die "close('$FILE'): $!\n";
   die "sysread($FILE) \@$number: $!\n"  if ! defined $n;
   $at->{$FILE} += $n;
   return $retval;
}

my $highlight = "\e[1;97;45m"; my $reset = "\e[0m";
my $file = shift || __FILE__;
my @numbers = @ARGV ? @ARGV : qw< 4 5 2 >;
for my $n (@numbers) {
   my $chunk = readN($file, $n);
   say "got $n: $highlight$chunk$reset";
}
