#!/usr/bin/env perl

use Modern::Perl;

my($str, @words) = @ARGV;

my @result =
        sort {length($a) <=> length($b)}
        grep {is_completing($str, $_)} @words;
say @result ? $result[0] : "''";


sub is_completing {
    my($str, $word) = @_;
    $str =~ s/[^a-z]//gi;
    my %count; $count{lc($_)}++ for split //, $str;
    $word = join '', sort split //, $word;
    while (my($ch, $count) = each %count) {
        my $code = '$word =~ s/'.$ch.'{'.$count.',}//i';
        eval($code) or return 0;
    }
    return $word eq '';
}
