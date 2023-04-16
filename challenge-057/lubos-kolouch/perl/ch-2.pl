#!/usr/bin/perl
use strict;
use warnings;

sub shortest_unique_prefixes {
    my @words = @_;
    my @result;

    for my $word (@words) {
        my $prefix = "";
        for my $char ( split //, $word ) {
            $prefix .= $char;
            if ( !grep { $_ =~ /^$prefix/ } @result ) {
                push @result, $prefix;
                last;
            }
        }
    }

    return \@result;
}

my @input  = ( "alphabet", "book", "carpet", "cadmium", "cadeau", "alpine" );
my $result = shortest_unique_prefixes(@input);

print "[", join( ", ", @{$result} ), "]\n";
