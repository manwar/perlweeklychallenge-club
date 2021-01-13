#!/usr/bin/perl6

sub rotations(Str $original) {
    my $word = $original;
    my $word_length = $original.chars;
    my $rotation = 0;

    repeat {
        $rotation++;
        $word ~~ s/ ^ ( . ** { $rotation % $word_length} ) (.+)/$1$0/;
    } until ($word eq $original);

    return $rotation;
}

say rotations('xyxx');