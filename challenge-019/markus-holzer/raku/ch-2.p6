
my $lorem-ipsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dolor sed viverra ipsum nunc aliquet bibendum enim. In massa tempor nec feugiat. Nunc aliquet bibendum enim facilisis gravida. Nisl nunc mi ipsum faucibus vitae aliquet nec ullamcorper. Amet luctus venenatis lectus magna fringilla.";

multi sub MAIN( Int:D $width = 80, Str:D :$file )
{
	say word-wrap :$width, :text( $file.IO.slurp )
}

multi sub MAIN( $width = 80, :$text = $lorem-ipsum )
{
	say word-wrap :$width, :$text;
}

sub word-wrap( :$width, :$text )
{
	my $line = "";

	join "\n", gather 
	{

		for $text.words -> $word 
		{
			take $line 
			and $line = $word 
			and next 
				if $line.chars + $word.chars + 1 > $width;

			$line ~= " " ~ $word;
		}

		take $line;
	}
}