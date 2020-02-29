use strict;
use warnings;
use feature "say";

my $num = shift;
my $i = 1;
while (1) {
    my $result = $num * $i;
    if ($result =~ /^[01]*$/) {
        say "$num * $i = $result";
        last;
    }
    $i++;
}
