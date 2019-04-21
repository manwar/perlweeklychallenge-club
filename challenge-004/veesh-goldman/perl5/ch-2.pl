#! /usr/bin/perl

my $usage = <<"EOF";
USAGE:
$0  letters [file]

   letters - a string consisting of the letters to filter by
   file    - the name of a file to check for words. If ommited, checks STDIN

$0 will search through the file for words that can be made from 
the letters in the list argument. Each letter will only be used once.
EOF

die $usage unless @ARGV;

my $list = shift;

while (<>) {
  #remove newline
  chomp;
  #copy the string to check for letters
  my $string = $_;
  #remove any letter in our list from the word
  $string =~ s/$_//i for split //, $list;
  #if there's no word left, then print our original word
  CORE::say unless $string;
}
