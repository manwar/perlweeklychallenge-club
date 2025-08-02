my $message = "hello world";
my $key = "test";

use v5.38;
my $enc = vigenere(0, $key, $message);
say "Encoded message: $enc";
my $dec = vigenere(1, $key, $enc);
say "Decoded message: $dec";

# mode = 0 to encode, 1 to decode
sub vigenere($mode, $key, $message) {
    my $alph = "abcdefghijklmnopqrstuvwxyz";
    my $q = (length $message) / (length $key);
    $key .= $key x $q;
    while (length $key > length $message) {
	$key = substr $key, 0, -1;
    }
    my @msg_letters = split "", lc $message;
    my @key_letters = split "", lc $key;
    my @rots = map {index $alph, $_} @key_letters;
    my @ans_letters;
    for my $i (0 .. $#msg_letters) {
	if ($msg_letters[$i] =~ /\W/) {
	    push @ans_letters, $msg_letters[$i];
	    next;
	}
	my $v = index $alph, $msg_letters[$i];
	my $x = ($mode == 0) ? ($v + $rots[$i]) % 26 : ($v - $rots[$i]) % 26;
	my $let = substr $alph, $x, 1;
	push @ans_letters, $let;
    }
    return join "", @ans_letters;
}
