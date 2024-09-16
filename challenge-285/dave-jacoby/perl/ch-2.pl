#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{ uniq };
use Getopt::Long;

my $change;
my $verbose=0;
my %done;
GetOptions( 
    "change=i" => \$change, 
    "verbose" => \$verbose,
    );
if ( defined $change ) {
    my @output = make_change($change);
    my $output = scalar @output;
    %done = ();
    say <<"END";
    Input:  \$amount = $change
    Output: $output
END
    say join "\n\t", 'OUTPUT',@output if $verbose;
    exit;
}

my @examples = ( 9, 15, 25, 50, 55, 99, 100, 256 );

for my $example (@examples) {
    %done = ();
    my @output = make_change($example);
    my $output = scalar @output;
    say <<"END";
    Input:  \$amount = $example
    Output: $output
END
    say join "\n\t", 'OUTPUT',@output if $verbose;
}

sub make_change ( $amount, $so_far = [] ) {
    my %change = (
        P  => 1,
        N  => 5,
        D  => 10,
        Q  => 25,
        HD => 50,
    );

    if ( $amount < 0 ) {
        return;
    }
    if ( $amount == 0 ) {
        state $h = {};
        my $solution = format_solution( $so_far->@* );
        $h->{$solution} ++;
        # say qq{$solution ($h->{$solution})} if $verbose;
        return $solution;
    }
    my @output;
    for my $c ( sort { $change{$b} <=> $change{$a} } keys %change ) {
        no warnings 'recursion';
        my $value = $change{$c};
        next unless $amount >= $value;
        my $local = [];
        push $local->@*, $so_far->@*, $c;
        my $format = format_solution( @$local );
        next if $done{$format}++;
        push @output, make_change( $amount - $value, $local );
        @output = uniq @output;
    }
    return @output;
}

sub format_solution(@array) {
    my @output;
    for my $l (qw{ HD Q D N P }) {
        my $c = scalar grep { $l eq $_ } @array;
        @array = grep { $l ne $_ } @array;
        if ( $c > 1 )  { push @output, $c . $l }
        if ( $c == 1 ) { push @output, $l }
    }
    return join ' + ', @output;
}
