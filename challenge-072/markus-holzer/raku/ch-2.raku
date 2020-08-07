sub MAIN( Str $file where *.IO.r, UInt $from where * > 1, $to where * > 1 ) {
	.say for $file.IO.lines[ $from-1 .. $to-1 ] }