#!/usr/bin/env perl

print 'Perl:', &capital_detection('Perl'),"\n";
print 'TPF:', &capital_detection('TPF'),"\n";
print 'PyThon:', &capital_detection('PyThon'),"\n";
print 'raku:', &capital_detection('raku'),"\n";

sub capital_detection {
    my ($s)=@_;
    ($s =~ /^[A-Z]?[a-z]+$|^[A-Z]+$|^[a-z]+$/) ? 1 : 0;
}

