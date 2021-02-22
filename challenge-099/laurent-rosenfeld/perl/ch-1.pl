use strict;
use warnings;
use feature "say";

my $input = "abcde";
my @test_patterns = qw/a*e a*d ?b*d a*c?e/;
for my $pat (@test_patterns) {
    say "$pat: ", match($input, $pat)
}

sub match {
    my ($in, $pattern) = @_;
    $pattern =~ s/\*/.*/g;
    $pattern =~ s/\?/./g;
    $pattern = "^$pattern\$";
    return $in =~ /$pattern/ ? 1 : 0;
}
