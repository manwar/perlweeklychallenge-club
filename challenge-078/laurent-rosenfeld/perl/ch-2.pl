use strict;
use warnings;
use feature "say";

my @a = ( [[10, 20, 30, 40, 50],[3, 4]],
          [[7, 4, 2, 6, 3], [1, 3, 4]] );
left_rotate($_) for @a;

sub left_rotate {
    my $inref = shift;
    my ($in, $indices) = @$inref;
    say "\nInput array: @$in - Indices: @$indices";
        for my $i (@$indices){
        my @out = @$in[$i..$#{$in}, 0..$i -1];
        say "@out";
    }
}
