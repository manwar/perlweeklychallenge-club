use strict;
use warnings;

use strict;
use warnings;

my @truth = qw<abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;

sub draw_seven_segment {
    my $number = shift;
    my @lines  = ("") x 5;

    for my $digit ( split //, $number ) {
        my $segments = $truth[$digit];
        $lines[0] .= ( $segments =~ /a/ ? "-" x 7 : " " x 7 ) . " ";
        $lines[1] .= ( $segments =~ /f/ ? "|" : " " ) . ( " " x 6 ) . ( $segments =~ /b/ ? "|" : " " ) . " ";
        $lines[2] .= ( $segments =~ /g/ ? "-" x 7 : " " x 7 ) . " ";
        $lines[3] .= ( $segments =~ /e/ ? "|" : " " ) . ( " " x 6 ) . ( $segments =~ /c/ ? "|" : " " ) . " ";
        $lines[4] .= ( $segments =~ /d/ ? "-" x 7 : " " x 7 ) . " ";
    }

    return join "\n", @lines;
}

my $number = 200;
print draw_seven_segment($number), "\n";
