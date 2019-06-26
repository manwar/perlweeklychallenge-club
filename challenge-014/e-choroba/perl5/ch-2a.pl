#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use Cpanel::JSON::XS;

my $json = <DATA>;

my $data = Cpanel::JSON::XS->new->decode($json);
my %by_initials;
undef $by_initials{$data->{$_}{initials}}{$_} for keys %$data;

my @longest = ([""]);
while (my $word = <>) {
    chomp $word;
    $word = lc $word;
    if (my @path = path($word, [])) {
        if (length $word > length $longest[0][0]) {
            @longest = ([$word, \@path]);
        } elsif (length $word == length $longest[0][0]) {
            push @longest, [$word, \@path];
        }
    }
}

say "$_->[0]: ", map { map "[@$_] ", @$_ } @{ $_->[1] } for @longest;


sub path {
    my ($rest, $path) = @_;

    return [$path] if "" eq $rest;

    my @solutions;
    for my $length (1, 2) {
        next if $length > length $rest;

        my $prefix = substr $rest, 0, $length;
        next unless exists $by_initials{$prefix};

        for my $state (keys %{ $by_initials{$prefix} }) {
            next if @$path
                 && ((grep $_ eq $state, @$path)
                      || ! grep $state eq $_,
                           @{ $data->{ $path->[-1] }{adjacent} });
            push @solutions, path(substr($rest, $length), [ @$path, $state ]);
        }
    }
    return @solutions
}
__DATA__
{"AL":{"name":"Alabama","initials":"a","adjacent":["FL","GA","TN","MS"]},"AK":{"name":"Alaska","initials":"a","adjacent":[]},"AZ":{"name":"Arizona","initials":"a","adjacent":["NM","UT","NV","CA"]},"AR":{"name":"Arkansas","initials":"a","adjacent":["LA","MS","TN","MO","OK","TX"]},"CA":{"name":"California","initials":"c","adjacent":["AZ","NV","OR"]},"CO":{"name":"Colorado","initials":"c","adjacent":["NM","OK","KS","NE","WY","UT"]},"CT":{"name":"Connecticut","initials":"c","adjacent":["RI","MA","NY"]},"DE":{"name":"Delaware","initials":"d","adjacent":["NJ","PA","MD"]},"FL":{"name":"Florida","initials":"f","adjacent":["GA","AL"]},"GA":{"name":"Georgia","initials":"g","adjacent":["SC","NC","TN","AL","FL"]},"HI":{"name":"Hawaii","initials":"h","adjacent":[]},"ID":{"name":"Idaho","initials":"i","adjacent":["WA","OR","NV","UT","WY","MT"]},"IL":{"name":"Illinois","initials":"i","adjacent":["WI","IA","MO","KY","IN"]},"IN":{"name":"Indiana","initials":"i","adjacent":["IL","KY","OH","MI"]},"IA":{"name":"Iowa","initials":"i","adjacent":["MN","SD","NE","MO","IL","WI"]},"KS":{"name":"Kansas","initials":"k","adjacent":["OK","MO","NE","CO"]},"KY":{"name":"Kentucky","initials":"k","adjacent":["TN","VA","WV","OH","IN","IL","MO"]},"LA":{"name":"Louisiana","initials":"l","adjacent":["MS","AR","TX"]},"ME":{"name":"Maine","initials":"m","adjacent":["NH"]},"MD":{"name":"Maryland","initials":"m","adjacent":["DE","PA","WV","VA"]},"MA":{"name":"Massachusetts","initials":"m","adjacent":["NH","VT","NY","CT","RI"]},"MI":{"name":"Michigan","initials":"m","adjacent":["WI","IN","OH"]},"MN":{"name":"Minnesota","initials":"m","adjacent":["ND","SD","IA","WI"]},"MS":{"name":"Mississippi","initials":"m","adjacent":["AL","TN","AR","LA"]},"MO":{"name":"Missouri","initials":"m","adjacent":["AR","TN","KY","IL","IA","NE","KS","OK"]},"MT":{"name":"Montana","initials":"m","adjacent":["ID","WY","SD","ND"]},"NE":{"name":"Nebraska","initials":"n","adjacent":["KS","MO","IA","SD","WY","CO"]},"NV":{"name":"Nevada","initials":"n","adjacent":["AZ","UT","ID","OR","CA"]},"NH":{"name":"NewHampshire","initials":"nh","adjacent":["VT","MA","ME"]},"NJ":{"name":"NewJersey","initials":"nj","adjacent":["NY","PA","DE"]},"NM":{"name":"NewMexico","initials":"nm","adjacent":["TX","OK","CO","AZ"]},"NY":{"name":"NewYork","initials":"ny","adjacent":["PA","NJ","CT","MA","VT"]},"NC":{"name":"NorthCarolina","initials":"nc","adjacent":["VA","TN","GA","SC"]},"ND":{"name":"NorthDakota","initials":"nd","adjacent":["MT","SD","MN"]},"OH":{"name":"Ohio","initials":"o","adjacent":["MI","IN","KY","WV","PA"]},"OK":{"name":"Oklahoma","initials":"o","adjacent":["TX","AR","MO","KS","CO","NM"]},"OR":{"name":"Oregon","initials":"o","adjacent":["CA","NV","ID","WA"]},"PA":{"name":"Pennsylvania","initials":"p","adjacent":["OH","WV","MD","DE","NJ","NY"]},"RI":{"name":"RhodeIsland","initials":"ri","adjacent":["MA","CT"]},"SC":{"name":"SouthCarolina","initials":"sc","adjacent":["NC","GA"]},"SD":{"name":"SouthDakota","initials":"sd","adjacent":["NE","IA","MN","ND","MT","WY"]},"TN":{"name":"Tennessee","initials":"t","adjacent":["AL","GA","NC","VA","KY","MO","AR","MS"]},"TX":{"name":"Texas","initials":"t","adjacent":["LA","AR","OK","NM"]},"UT":{"name":"Utah","initials":"u","adjacent":["AZ","CO","WY","ID","NV"]},"VT":{"name":"Vermont","initials":"v","adjacent":["NY","MA","NH"]},"VA":{"name":"Virginia","initials":"v","adjacent":["MD","WV","KY","TN","NC"]},"WA":{"name":"Washington","initials":"w","adjacent":["OR","ID"]},"WV":{"name":"WestVirginia","initials":"wv","adjacent":["VA","MD","PA","OH","KY"]},"WI":{"name":"Wisconsin","initials":"w","adjacent":["MN","IA","IL","MI"]},"WY":{"name":"Wyoming","initials":"w","adjacent":["CO","NE","SD","MT","ID","UT"]}}
