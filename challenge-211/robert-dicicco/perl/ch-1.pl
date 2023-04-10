#!/usr/bin/env perl
=begin pod
-------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-04-08
Challenge 211 Toeplitz Matrix ( Perl )
-------------------------------------------
=cut
use strict;
use warnings;
use feature 'say';
use List::MoreUtils qw(uniq);

#my @matrix = ([4, 3, 2, 1],[5, 4, 3, 2],[6, 5, 4, 3]);
my @matrix = ([1,2,3],[3,2,1]);

my $cols = scalar @{$matrix[0]};
my $rows = scalar @matrix;

my $r = 0;
my $c = 0;
my @out = ();
my $flag = 0;

sub CheckDiag {
    my @o = @{$_[0]};
    my @o_u = uniq @o;
    if (scalar @o_u != 1) {
        $flag = -1
    }
}

sub Diag {
    @out = ();
    while ($r < $rows) {
        push(@out,$matrix[$r][$c]);
        if ($r == $rows - 1) {
            CheckDiag(\@out);
            return;
        } else {
            if ($c == $cols - 1) {
                CheckDiag(\@out);
                last;
            };
            $c++;
            $r++;
        }
    }
}

my $x = 0;
print "Input matrix = [ ";
while ($x < $rows) {
    print "[",@{$matrix[$x++]},"] ";
}

$c = 0;
$r = 0;
while ($c < $cols - 1) {
    Diag($c,$r);
    $c++;
}

$r = 1;
$c = 0;
while ($r < $rows - 1) {
    Diag($c,$r);
    $r++;
}
print "]\n";

$flag == -1 ? say "Output: false" : say "Output: true";

=begin pod
-------------------------------------------
SAMPLE OUTPUT
perl .\Toeplitz.pl
Input matrix = [ [4321] [5432] [6543] ]
Output: true

perl .\Toeplitz.pl
Input matrix = [ [123] [321] ]
Output: false
-------------------------------------------
=cut


