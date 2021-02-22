# The Weekly Challenge 097
# Usage (Example):
# $ perl ch-1.pl "THE WEEKLY CHALLENGE" 3
# output: QEB TBBHIV ZEXIIBKDB

sub cipher {
    my $c = $_[0];
    if ($c =~ /^[A-Z]$/) {
      my $encrypted 
        = chr( ( ord($c)  - ord('A') - $leftshift) % 26 + ord('A') );
      return $encrypted;
    } else {
        return $c;
    }
}

$original = $ARGV[0];
$leftshift = $ARGV[1];
my @a = split //, $original; 
my @e = map { cipher($_) } @a;

print join '', @e;

print "\n";
