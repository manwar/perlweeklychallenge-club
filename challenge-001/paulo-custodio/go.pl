#!/usr/bin/env perl

use Modern::Perl;
use Path::Tiny;

@ARGV==1 && $ARGV[0]=~/^\d+$/ && $ARGV[0]>0
    or die "Usage: ",path($0)->basename," nr\n";
my $nr = sprintf("%03d", $ARGV[0]);

path("challenge-$nr/paulo-custodio")->mkpath;
#for my $dir (qw(ada awk basic bc brainfuck c cpp d forth fortran lua pascal perl python t)) {
for my $dir (qw( perl python t )) {
    path("challenge-$nr/paulo-custodio/$dir")->mkpath;
}

path("challenge-$nr/paulo-custodio/README")->spew("Solution by Paulo Custodio\n");
if (! -f "challenge-$nr/paulo-custodio/Makefile") {
    path("challenge-$nr/paulo-custodio/Makefile")->spew(
         "all:\n\tperl ../../challenge-001/paulo-custodio/test.pl\n");
}

chdir("challenge-$nr/paulo-custodio");
system("bash");
