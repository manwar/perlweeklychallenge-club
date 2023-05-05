use strict;
use warnings;

sub min_rotations {
    my ($word) = @_;
    my $original_word = $word;
    my $rotation_count = 1;

    while (1) {
        my $rotation = $rotation_count % length($word);
        $word = substr($word, $rotation) . substr($word, 0, $rotation);
        last if $word eq $original_word;
        $rotation_count += 1;
    }

    return $rotation_count;
}

my $word = 'xyxx';
print "Minimum non-zero rotations for '$word': ", min_rotations($word), "\n";  # Output: 7

