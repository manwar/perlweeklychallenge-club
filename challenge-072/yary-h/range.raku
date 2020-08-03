#!/usr/bin/env raku

# Run as:
# range.pl 4 10 < input.txt
# or
# range.pl 4 10 input.txt

# Playing with command-line validation.
# Lines are ints, end_line is greater than begin_line,
# all input files are readable- OK to skip that, CatHandle would complain.
sub MAIN(Int $line_to_start is copy,				#= First line to print
         Int $end_line where * >= $line_to_start,	#= Last line to print
         *@input_file where (*.all).IO.f #= File(s) to read from. Also reads STDIN.
	) {
	.say if --$line_to_start < 1
		for IO::CatHandle.new(@input_file, $*IN).lines($end_line)
	# Alternative would be to use .lines.kv to get line num with line
}
