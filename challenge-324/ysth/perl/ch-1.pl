use 5.036;

@ARGV = qw(2 2 1 2 3 4) unless @ARGV;
my ($r, $c, @ints) = map int, @ARGV;
unless ($r >= 0 && $c >= 0 && @ints == $r * $c) {
    die "expected count of rows, count of columns, and list of that many integers\n";
}

my @out = map [splice @ints, 0, $c], 1..$r;

use Data::Dumper;
say Data::Dumper->new([$_])->Terse(1)->Indent(0)->Dump for @out;
