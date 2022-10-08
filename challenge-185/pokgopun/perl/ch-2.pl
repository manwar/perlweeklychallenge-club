use strict;
use warnings;

### randomly assign @ARGV if not present
unless (@ARGV){
	@ARGV = int(rand(2)) ? ('ab-cde-123', '123.abc.420', '3abc-0010.xy') : ('1234567.a', 'a-1234-bc', 'a.b.c.d.e.f');
}

printf "Input: \@list = (%s)\n", join(", ", map{"'$_'"} @ARGV);
print "Output: (";
my $argCount = @ARGV;   ### track number of argument(s) for correctly put separator(s) between them
foreach my $arg (@ARGV) {
	my $out = "";   ### for storing masked argument
	my $cntdwn = 4; ### count down number of chars to replace
	my $parseLen = 0; ### track chars parsed to append remaining unparsed chars
	foreach my $o ($arg =~ /([\WA-Z_]*[a-z0-9])/g){   ### extract a character along with possibly preceeding non-characters
		last unless $cntdwn--;
		$parseLen += length $o;
		$o =~ s/[a-z0-9]/x/ if $o;
		$out .= $o;
	}
	printf "'%s'%s", $out.substr($arg, $parseLen), --$argCount ? ", " : "";
}
print ")\n\n";
