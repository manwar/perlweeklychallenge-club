# The Weekly Challenge 190
# Task 1 Capital Detection
use v5.30.0;

my $c1 = '^[A-Z][a-z]*$';
my $c2 = '^[a-z]+$';
my $c3 = '^[A-Z]+$';

say good($ARGV[0]) if $ARGV[0];

sub good {
    return 1 if $_[0] =~ m/$c1/ || $_[0] =~ m/$c2/ || $_[0] =~ m/$c3/;
    return 0;
}

use Test::More tests=>4;
ok good('Perl');
ok good('TPF');
ok !good('PyThon');
ok good('raku');
