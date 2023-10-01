# The Weekly Challenge 236
# Task 1 Excat Change
use v5.30;
use warnings;
use List::Util qw/all/;

sub ec {
    my @bills = @_;
    die "Bills not in presumed conditions.\n" 
        unless all {$_ == 5 || $_ == 10 ||$_ == 20} @bills;
    my $i = 0;
    my $fNotes = 0;
    my $dNotes = 0;
    my $zNotes = 0;
    while ($i <= $#bills) {
        my $input = $bills[$i];
        $fNotes += 1 if $input == 5;
        if ($input == 10) {
            if ($fNotes >= 1) {
                $fNotes -= 1;
                $dNotes += 1;
            }
            else {
                return 0;
            }
        }
        if ($input == 20) {
            if ($fNotes >= 1 && $dNotes >= 1) {
                $dNotes -= 1;
                $fNotes -= 1;
                $zNotes += 1;
            }
            elsif ($fNotes >= 3) {
                $fNotes -= 3;
                $zNotes += 1;
            }
            else {
                return 0;
            }
        }
        $i++;
    }
    return 1;
}

use Test::More tests=>3;
ok ec(5, 5, 5, 10, 20);
ok !ec(5, 5, 10, 10, 20);
ok ec(5, 5, 5, 20);
