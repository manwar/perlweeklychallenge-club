#!/usr/bin/perl
use strict;
use warnings;
use feature qw /say/;
use constant start_dict_size => 256;
use utf8;

sub encode {
    my $in = shift;
    my %dict = map { chr $_ => $_ } 0 .. start_dict_size - 1;
    my $ω = "";
    my @result;

    for my $c (split //, $in) {
        my $ωc = $ω . $c;
        if (exists $dict{$ωc}) {
            $ω = $ωc;
        } else {
            push @result, $dict{$ω};
            $dict{$ωc} = scalar keys %dict;
            $ω = $c;
        }
    }
    push @result, $dict{$ω} if length $ω;
    return @result;
}
sub decode {
    my @encoded = @_;
    my $dict_size = start_dict_size;
    my %dict = map { $_ => chr } 0 .. start_dict_size - 1;;
    my $ω = $dict{shift @encoded};
    my @result = ($ω);
    for my $i (@encoded) {
        my $str;
        if (exists $dict{$i}) {
            $str = $dict{$i};
        } elsif  ($i == $dict_size) {
            $str = $ω . substr $ω, 0, 1;
        } else { die "Error on $i" }
        push @result, $str;
        $dict{$dict_size++} = $ω . substr $str, 0, 1;
        $ω = $str;
    }
    return join "", @result;
}

my $input_str = 'TOBEORNOTTOBETOBEORNOTTOBETOBEORNOTTOBE';
my @encoded = encode $input_str;
say "@encoded";
say decode(@encoded);
