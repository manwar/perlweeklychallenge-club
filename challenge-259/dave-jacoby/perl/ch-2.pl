#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use JSON;
use List::Util qw{ sum0 };

my $json = JSON->new->pretty->canonical;

my @examples = (

    '{%  youtube title="Title with escaped backslash \\" %}',
    '{%  id   field1="value1"    field2="value2"  field3=42 %}',
    '{%  jacoby language1="perl" language2="javascript" hobby="guitar" %}',
    '{%  hansolo ship="falcon"    friend="wookie"  love="leia" %}',
    '{%  linkedin jobs="multiple words in one line" %}',
    '{%  youtube answer=42       title="Title \"quoted\" done" %}',
);

for my $example (@examples) {
    my $output = line_parse($example);
    my $jo     = $json->encode($output);

    say <<~"END";
    Input:  \$line = '$example'

    Output: 
        $jo
    END
}

sub line_parse ($line) {
    my $output = {};
    while ( $line !~ /^\{\% \s* \%\}/ ) {

        # value matches word="word"
        if ( $line =~ /^\{\% \s* \w+=\"\w+\"/ ) {
            my ( $field, $value ) = $line =~ /(\w+)=\"(\w+)\"\s/;
            $output->{field}{$field} = $value;
            $line =~ s{(\w+=\"\w+\")\s}{};
            next;
        }

        # value matches word=number
        if ( $line =~ /^\{\% \s* \w+=\d+/ ) {
            my ( $field, $value ) = $line =~ /(\w+)=(\d+)\s/;
            $output->{field}{$field} = $value;
            $line =~ s{(\w+=\d+)\s}{};
            next;
        }

        # value matches word="word word word" and also backslash
        if ( $line =~ /^\{\% \s* \w+=\"[\s\w\\\"]+\"/ ) {
            my ( $field, $value ) = $line =~ /(\w+)=\"([\s\w\\\"]+)\"\s/;
            $output->{field}{$field} = $value;
            $line =~ s{(\w+=\"[\s\w\\\"]+\")\s}{};
            next;
        }

        # value matches only word
        if ( $line =~ /^\{\% \s* \w+/ ) {
            my ($field) = $line =~ m{(\w+)};
            $line =~ s{(\w+)}{}mix;
            if   ( $output->{name} ) { $output->{field}{$field} = ''; }
            else                     { $output->{name}          = $field; }
            next;
        }
        substr( $line, 3, 1 ) = '';
    }
    return $output;
}
