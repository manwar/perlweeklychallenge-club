use strict;
use warnings;
use feature qw/say/;
use constant MAX => 4;

my @tests = qw<ab-cde-123  123.abc.420  3abc-0010.xy  1234567.a
               a-1234-bc  a.b.c.d.e.f  12__34567.a>;
for my $test (@tests) {
    my $result = "";
    my $count = 0;
    for my $char (split //, $test) {
        if ($count < MAX and $char =~ /[A-Za-z0-9]/) {
            $char = 'x';
            $count++;
        }
        $result .= $char;
    }
    say "$test\t => $result";
}
