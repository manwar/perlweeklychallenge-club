#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_Vars /;

sub usage {
print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <name>
-USAGE-
    exit 0;
}

if (scalar @ARGV < 1) {
    usage;
}

my ($name) = @ARGV;
my $stem = $name;
$stem =~ s/^ [^AaEeIiOoUu] //msx;
$stem = lc $stem;

my $labial = $name =~ / ^ ([BbFfMm]) /msx;
say "$name, $name, bo-", ($labial ? q{} : 'b'), "$stem";
say "Bonana-fana fo-", ($labial ? q{} : 'f'), "$stem";
say "Fee fi mo-", ($labial ? q{} : 'm'), "$stem";
say "$name!";
