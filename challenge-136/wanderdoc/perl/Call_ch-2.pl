#!perl
use strict;
use warnings FATAL => qw(all);

use IPC::System::Simple qw(systemx capturex);
use FindBin qw($Bin);
use Time::HiRes qw (gettimeofday tv_interval);

my $t0 = [gettimeofday];








open my $out, ">", "$Bin/output.txt" or die "$!";
for my $i ( 3 .. 1_000)
{
     print {$out} "$i: $/";
     my $script = "$Bin/ch-2.pl";
     # systemx("perl",  $script, $i);
     my @output = capturex("perl", $script, $i);
     print {$out} @output;

     my $elapsed = tv_interval ( $t0, [gettimeofday]);
     print {$out} $elapsed, $/;
     $t0 = [gettimeofday];
}