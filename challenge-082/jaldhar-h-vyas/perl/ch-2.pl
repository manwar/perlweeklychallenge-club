#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <A> <B> <C>
-USAGE-

    exit 0;
}

if (scalar @ARGV != 3) {
    usage;
}

my ($A, $B, $C) = @ARGV;
my $result;
my $copy = $C;

while (length $A || length $B) {
    "$A\0$copy" =~ /\A (.*) .* \0 \1/msx;
    my $prefixa = $1;
    $result .= $prefixa;
    $A =~ s/\A $prefixa//msx;
    $copy =~ s/\A $prefixa//msx;

    "$B\0$copy" =~ /\A (.*) .* \0 \1/msx;
    my $prefixb = $1;
    $result .= $prefixb;
    $B =~ s/\A $prefixb//msx;
    $copy =~ s/\A $prefixb//msx;
}

say $result eq $C ? 1 : 0;