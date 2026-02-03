#!/usr/bin/env perl

use Modern::Perl;

@ARGV==1 or die "usage: $0 str\n";
say replace_question($ARGV[0]);

sub replace_question {
    my($str) = @_;
    while ($str =~ /\?/g) {
        my $pos = pos($str) - 1;
        my $before = $pos>0 ? substr($str, $pos-1, 1) : "";
        my $after = $pos<length($str) ? substr($str, $pos+1, 1) : "";
    letter:
        for my $c ('a' .. 'z') {
            if ($c ne $before && $c ne $after) {
                $str =~ s/$before\?$after/$before$c$after/;
                last letter;
            }
        }
    }
    return $str;
}
