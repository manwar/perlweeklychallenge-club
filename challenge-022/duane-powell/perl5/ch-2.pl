#!/usr/bin/perl
use Modern::Perl;

# Write a script to implement Lempel Ziv Welch (LZW) compression algorithm. 
# The script should have method to encode/decode algorithm.
my $str = shift || "TOBEORNOTTOBEORTOBEORNOT";

my $LZW = LZW->new();
my @e = $LZW->encode($str);
my $d = $LZW->decode(@e);
say "@e";
say "$d";
exit;

package LZW;
use Data::Dumper;
sub new {
	return bless { DEBUG => 0 }, shift;
}

sub encode {
	my $self = shift;
	my @input = split("",shift);
	my @output; 

	# dictionary to encode bytes into keys
	my %dict = map { chr($_) => $_ } (0 .. 255);
	my $key = '';

	foreach my $byte (@input) {
		# Add entries to our dictionary by building longer and longer keys,
		# the side effect being compression. The more the key is used or 
		# the longer key gets ... the more compression.
		my $next_key = $key . $byte;
		if (exists $dict{$next_key}) {
			$key = $next_key;
		} else {
			push @output, $dict{$key};
			# Because we're 0 indexed $next_key equals number of keys 
			# eg. (0..255), scalar(keys %dict) == 256, next key is 256
			$dict{$next_key} = scalar(keys %dict);
			$key = $byte;
		}
	}
	push @output, $dict{$key} if ($key);
	say Dumper(\%dict) if ($self->{DEBUG});
	return @output;
}

sub decode {
	my $self = shift;
	my @input = @_;
	my @output;

	# dictionary to decode from keys back to bytes
	my %dict = map { $_ => chr($_) } (0 .. 255);
	my $byte = '';

	foreach my $key (@input) {
		my $str;

		# The first key (byte) could never be encoded, 
		# because we had nothing to compare it too.
		$str = chr($key) if not ($byte);

		my $next_key = scalar(keys %dict);
		if (exists $dict{$key}) {
			$str = $dict{$key};
		} elsif ($key == $next_key) {
			$str = $byte . substr($byte,0,1);
		} else {
			die "decoding failed.";
		}

		# Reconstruct dictionary by concatenating previous entries.
		# If you data dump the dictionary, you will see that a
		# key's last byte always equals the next key's first byte.
		$dict{$next_key} = $byte . substr($str,0,1) if ($byte);
		push @output, $str;
		$byte = $str;
	}
	say Dumper(\%dict) if ($self->{DEBUG});
	return join("",@output);
}
 
1;

__END__

This was a cool problem. 
I didn't write the above from scratch... 
I had to read lots of psuedo code and examples,
but now I understand how LZW compression works!

./ch-2.pl
84 79 66 69 79 82 78 79 84 256 258 260 265 259 261 263
TOBEORNOTTOBEORTOBEORNOT

./ch-2.pl "A"
65
A

./ch-2.pl "AAA"
65 256
AAA

./ch-2.pl "AAABBBCCC"
65 256 66 258 67 260 
AAABBBCCC

