#! /usr/bin/perl
use v5.22;
my @to_table = ( 0 .. 9, 'A' .. 'Y');
my %from_table;
while (my ($index, $element) = each @to_table) {
    $from_table{$element} = $index;
}

sub convert_to {
    my $x = shift;  my $pow = 1; my @ret;
    do {
        my $digit = $x % 35;
        unshift @ret, $to_table[$digit];
        $x -= $digit;
        $x /= 35;
    } while $x > 0;
    return join '', @ret
}

sub convert_from {
    my $x; my $pow =1;
    for (reverse split //, shift) {
        $x += $from_table{$_} * $pow;
        $pow *= 35;
    }
    return $x
}

my $command = shift;
if ($command eq 'to') {
    my $arg = shift;
    die 'Need a number to convert' unless $arg;
    die 'Improper base10 number' unless $arg =~ /^\d+$/;
    say convert_to($arg)
} elsif ($command eq 'from') {
    my $arg = shift;
    die 'Need a number to convert' unless $arg;
    die 'Improper base35 number' unless $arg =~ /^[0-9A-Y]+$/;
    say convert_from($arg)
} else {
    say <<"EOF"
    USAGE: $0 [ to | from ]
      to - will convert a base10 number to base35
      from - will convert a base35 number to base10
EOF
}
