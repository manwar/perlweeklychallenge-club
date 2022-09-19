use strict;
use warnings;
use feature qw/say/;

my @input = qw <
    /a/b/c/1/x.pl
    /a/b/c/d/e/2/x.pl
    /a/b/c/d/3/x.pl
    /a/b/c/4/x.pl
    /a/b/c/d/5/x.pl
    >;

my @paths;
for my $line (@input) {
    $line =~ s|^/||;
    my @subpaths = split /\//, $line;
    push @paths, [@subpaths[0..$#subpaths-1]];
}

my @first = @{$paths[0]};
my $end = $#paths;
my $k = 0;
OUTLOOP: for my $i (0..$#first) {
    for my $j (0..$end) {
        if ((not exists $paths[$j][$i]) or $paths[$j][$i] ne $first[$i]) {
            $k = $i - 1;
            last OUTLOOP;
        }
    }
}
say '/', join '/', @first[0..$k];
