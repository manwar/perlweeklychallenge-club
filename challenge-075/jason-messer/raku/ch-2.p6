#! /usr/bin/env rakudo

sub largest-rectangle( @a ) {
	my @r = gather loop (my $i = 0; $i < @a.elems; ++$i) {

		my $height = @a[$i];
		my $width = 1;
		loop (my $back = $i - 1; $back >= 0; --$back) {
			last if @a[$back] < $height;
			$width++;
		}
		loop (my $forward = $i + 1; $forward < @a.elems; ++$forward) {
			last if @a[$forward] < $height;
			$width++;
		}
		take $width *  $height;
	}
	return max(@r);
}

sub print-histogram( @a ) {
	loop (my $height = max(@a); $height > 0; --$height) {
		my Str @parts = $height.Str xx 1;
		@parts.append: @a.map( {$_ >= $height ?? '#' !! ' '} );
		say @parts.join: ' ';
	}
	say "- " x @a.elems + 1;
	say '  ', @a.join: ' ';
}

my @A = [2, 1, 4, 5, 3, 7];
my @B = [3, 2, 3, 5, 7, 5];

print-histogram(@A);
say "area: ", largest-rectangle(@A);

print-histogram(@B);
say "area: ", largest-rectangle(@B);
