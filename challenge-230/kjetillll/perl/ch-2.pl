use strict; use warnings;

sub wwp {
    my($prefix, @words) = @_;
    0 + grep /^$prefix/, @words
}

my $prefix = "at";
my @words = ("pay", "attention", "practice", "attend");

print "Number of word with prefix '$prefix': ";
print wwp($prefix,@words);
print "\n";
