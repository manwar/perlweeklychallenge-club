#!/home/chuck/rakudo/bin/perl6

use strict;

print "ch-2.p6 (Version 1.0) PWC #42 Task #2: Balanced Brackets\n";

sub create_brackets {
	my ($nr) = @_;
	my $s;
	loop ( my $i=0; $i <= $nr; $i++ )  {
		my $br = Int(2.rand);
		if ($br) { $s ~= ")"; } else { $s ~= "("; }
	}
	return $s;
}

my $ok;
repeat {
	my $nr = Int(10.rand);
	my $str = create_brackets($nr);
	$ok  = balanced_brackets($str);
	my $rs  = "NOT OK";
	$rs = "OK" if $ok;
	print $str, " - ", $rs, "\n";
} while ( ! $ok );

sub balanced_brackets ($arg) {
	my $str = $arg;  # Cannot assign to a read-only.
	my $found = ($str ~~ s/\(\)//);
	my $ok;
	if ($found) { 
		$ok = balanced_brackets($str);
		return $ok;
	}
	else { 
		if ( $str ~~ /\(|\)/ ) { return 0; }
		else { return 1; }
	}
}

