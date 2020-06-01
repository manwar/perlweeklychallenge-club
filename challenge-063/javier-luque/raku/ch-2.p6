# Test: perl6 ch-2.p6

sub MAIN() {
    say rotate('xyxx') ~ ' rotations';
}

sub rotate(Str $word) {
    my $copy = $word;

    # The total length of the word
    my $total_word_length = $word.chars;
    my $i = 0;

    repeat {
    	$i++;
    	my $position = $i % $total_word_length;
    	my $length   = $total_word_length - $position;

    	$copy = $copy.substr($position, $length) ~
    	        $copy.substr(0, $position);

    	say "Rotation $i: $copy";
    } while ($copy ne $word);

    return $i;
}
