#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

open my $d, q(<), 'dictionary.txt';
chomp(my @words = <$d>);
close $d;
my @abcde;

O: for my $w (@words) {
  my $f = '';
  $f gt $_ ? (next O) : ($f=$_) for split //, $w;
  push @abcde,$w;
}


say "\nML:";
say join ' ', ' * [W]', most_letters(       \@words );
say join ' ', ' * [A]', most_letters(       \@abcde );

say "\nNormal:";
say join ' ', ' * [W]', generate_a_pangram_random(       \@words );
say join ' ', ' * [A]', generate_a_pangram_random(       \@abcde );

say "\nShorter:";
say join ' ', ' * [W]', generate_a_pangram_random_short( \@words, 1e3 );
say join ' ', ' * [W]', generate_a_pangram_random_short( \@words, 1e6 );
say join ' ', ' * [A]', generate_a_pangram_random_short( \@abcde, 1e3 );
say join ' ', ' * [A]', generate_a_pangram_random_short( \@abcde, 1e6 );

say "\nAlphabetic order:";
say join ' ', ' * [W]', generate_a_pangram_alpha_order(  \@words );

say "\nOne letter at a time (alpha):";
say join ' ', ' * [W]', generate_one_letter_at_time(     \@words );
say join ' ', ' * [W]', generate_one_letter_at_time_longest( \@words );



sub generate_a_pangram_random {
  my ($list,$c,%letters,@pangram) = (shift,0,map { $_ => 0 } 'a'..'z');
  O: while( $c < 26 ) {
    my($f,@l) = (1,split //, my $word = $list->[rand @{$list}]);
    $f *= $letters{$_} foreach @l;
    next if $f;
    push @pangram, $word;
    $letters{$_} || ( $letters{$_}=1, $c++ ) for @l;
  }
  @pangram;
}

sub generate_a_pangram_random_short {
  my ($m,$list,$loop,@mw) = (1e6,@_);
  for(1..$loop) {
    my @w = generate_a_pangram_random( $list );
    my $l = length join '', @w;
    if( $l < $m ) {
      @mw = @w;
      $m = $l;
    }
  }
  @mw;
}

sub generate_a_pangram_alpha_order {
  my ($list,$next,%letters,@pangram) = (shift,'a',map { $_ => 0 } 'a'..'z');
  O: until( 'aa' eq $next ) {
    my($best,$best_length,$best_word) = (0,0,'');
    W: foreach my $word ( @{$list} ) {
      my %t = map { $_=>1 } split //, $word;
      my ($score,$ch) = (0,$next);
      ($_ gt $ch) ? next W : ($score++,$ch++) for sort grep { $_ ge $next } keys %t;
      next if $score < $best;
      if( $score > $best ) {
        ($best,$best_word,$best_length) = ($score,$word,length $word);
      } elsif( $best_length > length $word ) {
        ($best_word,$best_length) = ($word,length $word);
      }
    }
    push @pangram, $best_word;
    $next++ foreach 1..$best;
  }
  @pangram;
}

sub generate_one_letter_at_time {
  my ($list,$next,%letters,@pangram) = (shift,'a',map { $_ => 0 } 'a'..'z');
  O: until( 'aa' eq $next ) {
    my($best,$best_length,$best_word) = (0,1e6,'');
    W: foreach my $word ( @{$list} ) {
      my %t = map { $_=>1 } split //, $word;
      my @T = grep { $_ ge $next } keys %t;
      ($best_word,$best_length) = ($word,length $word) if @T == 1 && $T[0] eq $next && $best_length > length $word;
    }
    push @pangram, $best_word;
    $next++;
  }
  @pangram;
}

sub generate_one_letter_at_time_longest {
  my ($list,$next,%letters,@pangram) = (shift,'a',map { $_ => 0 } 'a'..'z');
  O: until( 'aa' eq $next ) {
    my($best,$best_length,$best_word) = (0,0,'');
    W: foreach my $word ( @{$list} ) {
      my %t = map { $_=>1 } split //, $word;
      my @T = grep { $_ ge $next } keys %t;
      ($best_word,$best_length) = ($word,length $word) if @T == 1 && $T[0] eq $next && $best_length < length $word;
    }
    push @pangram, $best_word;
    $next++;
  }
  @pangram;
}

sub most_letters {
  my ($list,$c,%letters,@pangram) = (shift,0,map{$_=>1}'a'..'z');
  while($c<26) {
    my( $most, $length, $best )=(0,1000,'');
    I: foreach my $word (@{$list}) {
      my %t = map { $_ => 1 } grep { $letters{$_} } split //, $word;
      if( $most < scalar keys %t ) {
        ($length,$best,$most) = (length $word,$word,scalar keys %t);
      } elsif( scalar keys %t == $most && $length > length $word ) {
        $length = length ($best=$word);
      }
    }
    $c+=$most;
    $letters{$_}=0 foreach split//,$best;
    push @pangram, $best;
  }
  @pangram;
}
