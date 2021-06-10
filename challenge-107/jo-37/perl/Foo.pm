package Foo;

# Some remainders from (unsuccessful) tests with B::Deparse
#
sub foo {}
our $BEGIN;
{my $bar; sub bar {$bar = shift}}
my $str = <<EOS;
sub foobar {}
EOS

$str =~ m{
    sub baz {1}
}x;
$str =~ s{.*} {
sub baz {1}
};


1;
