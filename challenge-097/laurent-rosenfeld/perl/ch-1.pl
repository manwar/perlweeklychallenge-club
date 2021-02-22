use strict;
use warnings;
use feature "say";
use constant MIN => ord 'A';

my $in_string = shift // "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG";
my $shift = shift // 3;
say rotate(uc $in_string, $shift);

sub rotate {
    my ($in, $shift) = @_;
    return join "",
        map { my $let = ord($_) - $shift;
              $let +=  26 if $let < MIN;
              $_ eq " " ? " " : chr $let
            } split "", $in;
}
