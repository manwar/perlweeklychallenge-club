use strict;
use warnings;
use feature "say";

sub merge_account {
    my %merged;
    for my $part (@_) {
        # say   Dumper $part;
        my ($key, @values) = @$part;
        $merged{$key}{$_} = 1 for @values;
    }
    # say %merged;
    return \%merged;
}

my @tests = ( [ [<A a1\@a.com a2\@a.com>],
                [<B b1\@b.com>],
                [<A a3\@a.com a1\@a.com>] ],

              [ [<A a1\@a.com a2\@a.com>],
                [<B b1\@b.com>],
                [<A a3\@a.com>],
                [<B b2\@b.com b1\@b.com>] ] );

for my $test (@tests) {
    # say Dumper $test, " => ";
    for my $part (@$test) {
        print join " ", @$part;
        print " - ";
    }
    say " =>";
    my %merged = %{merge_account @$test};
    for my $k (sort keys %merged) {
        say "\t[", (join " ", $k, sort keys %{$merged{$k}}), "]";
    };
    say "";
}
