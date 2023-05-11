#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( any all max ) ;

sub find_intersection {
  my $firstArray = shift ;
  my $secondArray = shift ;
  my %firstHash ;
  my %secondHash ;
  for my $letter( @{$firstArray} ) {
      $firstHash{ $letter }++ ;
  }
  for my $letter( @{$secondArray} ) {
      $secondHash{ $letter }++ ;
  }
  return grep { exists( $secondHash{ $_ } ) } keys %firstHash ;
}

sub find_most_frequent {
  my $array = shift ;
  my %vals ;
  for my $num ( @{$array} ) {
      $vals{ $num }++ ;
  }
  my $maximum = max ( values %vals ) ;
  my @nums = grep { $vals{ $_ } == $maximum } keys %vals ;
  return $nums[ 0 ] ;
}

#which letters are provided by which sticker ?
sub find_letter_distribution {
  my $stickerArray = shift ;
  my %letterDistri ;
  for my $i ( 0 .. scalar ( @{$stickerArray} - 1  ) ) {
      for my $letter ( split ( // , $stickerArray->[ $i ] ) ) {
    push @{$letterDistri{ $letter }} , $i ;
      }
  }
  return %letterDistri ;
}

say "Please enter some sticker words, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @stickers = split( /\s/ , $line ) ;
say "Please enter a word!" ;
my $word = <STDIN> ;
chomp $word ;
my %letters_in_words ;#in which words do I find a given letter ?
my $multistickers = 0 ;#how many stickers have to be used more than once?
my %supplied ; #how many letters are offered ?
my %needed ; #how many letters are needed ?
#which letters are supplied ? for every letter, fill a hash showing
#in which word the letter was found
%letters_in_words = find_letter_distribution( \@stickers ) ;
#tabulate how many letters are needed
for my $letter ( split( // , $word ) ) {
  $needed{ $letter }++ ;
}
for my $w ( @stickers ) {
  for my $let ( split // , $w ) {
      $supplied{ $let }++ ;
  }
}
my @supplied_letters = keys %supplied ;
my @needed_letters = keys %needed ;
#is there any needed character which is not supplied ?
if ( any { not exists( $supplied{ $_ } ) } @needed_letters ) {
  say 0 ;
}
#we supply enough characters
elsif ( all { $supplied{ $_ } >= $needed{ $_ } } @needed_letters ) {
  my %uniques ; #see in which stickers you found letters
  my @sorted = sort { $a cmp $b } split ( // , $word ) ;
  my @found ;
  for my $letter ( @sorted ) {
#look up in which sticker the character needed was found. Select the word
#where it was found most often
      push @found , find_most_frequent( \@{$letters_in_words{ $letter }} ) ;
  }
  map { $uniques{ $_ }++ } @found ;
  say scalar( keys %uniques ) ;
}
else { #we have at least one supplied letter for every letter we need, but
#we have to draw more than one sticker of the same word to fulfill our
#needs. We draw more than one from the words that supply the needed letter,
#in this order : 1)multiply the word that provides the letter needed
#2)if there are more than 1 word that provide letters find out which word
#contributes most letters to the word
  my @missing = grep { $supplied{ $_ } < $needed{ $_ } } @needed_letters ;
  for my $letter ( @missing ) {
      if ( all { $_ == ${$letters_in_words{ $letter }}[0] }
        @{$letters_in_words{ $letter }} ) {
    $multistickers = $needed{ $letter } - $supplied{ $letter } ;
    my $num = ${$letters_in_words{ $letter }}[0] ;
    $stickers[ $num ] = $stickers[ $num ] . ($stickers[ $num ] x
          $multistickers) ;
      }
      else { #we find the missing letters in more than 1 word
#which of the stickers has the greatest intersection with our target word ?
#which word of @stickers contributes most ?
    my %places_found ;
    for my $num ( @{$letters_in_words{ $letter }} ) {
        $places_found{ $num }++ ;
    }
    my @sorted = sort { $places_found{$b} <=> $places_found{$a} } keys
        %places_found ;
    $multistickers = $needed{ $letter } - $supplied{ $letter } -
        $sorted[ 0 ] ;
    my $selected = grep { $places_found{ $_ } == $sorted[ 0 ] } keys
        %places_found ;
    $stickers[ $selected ] = $stickers[ $selected ] . (
          $stickers[ $selected ] x $multistickers ) ;
      }
  }
  %letters_in_words = find_letter_distribution(\@stickers) ;
  my %uniqes ;
  my @sorted = sort { $a cmp $b } split( // , $word ) ;
  my @found ;
  for my $letter ( @sorted ) {
      push @found , find_most_frequent( \@{$letters_in_words{ $letter }} ) ;
  }
  map { $uniqes{ $_ }++ } @found ;
  say ( scalar( keys %uniqes ) + $multistickers ) ;
}
