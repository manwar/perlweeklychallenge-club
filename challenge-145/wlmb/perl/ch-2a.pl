#!/usr/bin/env perl
# Perl weekly challenge 145
# Task 2: Palindromic tree. Removing punctuation and diacritical marks
#
# See https://wlmb.github.io/2021/12/27/PWC145/#task-1-palindromic-tree
use v5.12;
use warnings;
use utf8;
use Encode qw(decode_utf8);
use Text::Wrap qw(wrap $columns $break);
use Text::Unidecode;

$columns=62;
$break=qr/\s/;

die "Usage: ./ch-2a.pl string to find palindrome substrings" unless @ARGV;
my ($imaginary_root, $root, $current);
my @letters;
foreach(@ARGV){ # assume utf8 in @ARGV
    my $s=decode_utf8($_,9);
    $imaginary_root={size=>-1, edges=>{}};
    $root={size=>0, edges=>{}};
    $current=$root;
    $_->{suffix}=$imaginary_root foreach($root, $imaginary_root);
    $s=~s/\p{Punct}//g; #remove punctuation
    $s=~s/\s*//g; #remove spaces
    @letters=split '', unidecode(lc $s); #ignore case, remove accents
    foreach(0..@letters-1){
	add_letter($_);
    }
    my $output=[()];
    palindromes($imaginary_root->{edges}->{$_}, $_, $output)
	foreach keys $imaginary_root->{edges}->%*;
    palindromes($root, "", $output);
    say "Input: $_\nOutput: ", wrap("", "        ",
        join ", ", sort {length $a <=> length $b or $a cmp $b} $output->@*);
}
sub add_letter {
    my $index=shift;
    my $letter=$letters[$index];
    $current=$current->{suffix}
        while $index-$current->{size}-1<0
            || $letters[$index-$current->{size}-1] ne $letter;
    $current=$current->{edges}{$letter}, return
        if defined $current->{edges}{$letter};
    my $suffix=$current->{suffix};
    $current=$current->{edges}->{$letter}
        ={size=>$current->{size}+2, edges=>{}};
    $current->{suffix}=$root, return if $current->{size}==1;
    $suffix=$suffix->{suffix}
        while $letters[$index-$suffix->{size}-1] ne $letter;
    $current->{suffix}=$suffix->{edges}->{$letter};

    return;
}

sub palindromes {
    my ($start, $center, $output)=@_;
    push @$output, $center if $center; # ignore the blank string of $root
    palindromes($start->{edges}->{$_}, $_.$center.$_, $output)
        foreach keys $start->{edges}->%*;
}
