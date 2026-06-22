use v5.36;

my $str = $ARGV[0] // die "Usage: $0 STRING\n";

my $rts = '';
$rts .= chop $str while length $str;

say $rts;
