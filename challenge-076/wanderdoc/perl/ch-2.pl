#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script that takes two file names. The first file would contain word search grid as shown below. The second file contains list of words, one word per line. You could even use local dictionary file. Print out a list of all words seen on the grid, looking both orthogonally and diagonally, backwards as well as forwards.
Output
Found 55 words of length 5 or more when checked against the local dictionary. You may or may not get the same result but that is fine.
argos, constitution, margo, patna, traci, tracie, aimed, align, antes, arose, ashed, blunt, blunts, broad, buries, clove, cloven, constitution, constitutions, croon, depart, departed, enter, filch, garlic, goats, grieve, grieves, hazard, liens, malign, malignant, malls, midst, ought, ovary, parted, pudgiest, quash, quashed, raped, ruses, shrine, shrines, social, socializing, spasm, spasmodic, succor, succors, theorem, theorems, virus, viruses, wigged
=cut






use File::Basename;
use Mojo::UserAgent;
use URI;
use FindBin qw($Bin);
use List::Util qw(sum);
use v5.10; # state.




# Download dictionary if it was not downloaded yet.

unless ( (-e "$Bin/words.txt") and (-s "$Bin/words.txt" > 5_000_000) )
{
     my $url = URI->new( 'https://github.com/dwyl/english-words/raw/master/words.txt' );
     my $file = basename( $url->path );
     my $response = Mojo::UserAgent->new->max_redirects(5)->get( $url->as_string )->res;
     die "Error while downloading a dictionary file!$/" unless 200 == $response->code;
     open my $fh, '>', "$Bin/$file" or die "$!";
     print {$fh} $response->body;
}



# Load dictionary.
my %dict;
{

     open my $in, "<", "$Bin/words.txt" or die "$!";
     while ( my $line = <$in> )
     {
          chomp $line;

          next unless length($line) >= 5;
          $dict{lc $line} = undef;
     }
}



# Load grid.

my @grid;
{
     open my $in, "<", "$Bin/grid.txt" or die "$!";
     while ( my $line = <$in> )
     {
          chomp $line;
          $line = lc $line;
          my @string = split(/\s/,$line);

          push @grid, [@string];
     }
}



print "First search:$/";
grid_search(\@grid, 5);

print "After 90-Rotation:$/";
grid_search(rotate_90([@grid]), 5);

print "After 45-Rotation:$/";
grid_search(rotate_45([@grid]), 5);

print "After 135-Rotation:$/";
grid_search(rotate_45(rotate_90([@grid])), 5);


# my $counter;
sub grid_search
{
     my ($aref, $length) = @_;
     state $counter;
     for my $part ( @$aref )
     {

          for my $i ( 0 .. $#$part - $length )
          {
               for my $j ( $length - 1 ..  $#$part)
               {
                    next unless $j - $i >= $length - 1;
                    my $chunk = join('',@{$part}[$i .. $j]);
                    my $reversed = reverse $chunk;
                    for my $candidate ( $chunk, $reversed )
                    {

                         print ++$counter, ' ', $candidate, $/ 
                              if exists $dict{$candidate};
                    }
               }
          }
     }
}


sub rotate_90
{
     my ($aref) = @_;
     my $rotated;
     for my $row_idx ( 0 .. $#$aref )
     {
          for my $col_idx ( 0 .. $#{$aref->[$row_idx]} )
          {
               $rotated->[$col_idx][$#$aref - $row_idx] = 
                         $aref->[$row_idx][$col_idx];
          }
     }
     return $rotated;
}

sub rotate_45
{
     my $aref = $_[0];
     my $rotated;
     for my $row_idx ( 0 .. $#$aref )
     {
          for my $col_idx (0 .. $#{$aref->[$row_idx]})
          {
               push @{$rotated->[ sum($row_idx, $col_idx)]},
                    $aref->[$row_idx][$col_idx];
          }
     }
     return $rotated;
}

=output
First search:
1 aimed
2 succor
3 succors
4 wigged
5 buries
6 butea
7 izing
8 socializing
9 social
10 midst
11 midsts
12 broad
13 goats
14 ovary
15 patna
16 malignant
17 angil
18 align
19 malign
20 virus
21 viruses
22 ruses
23 garlic
24 filch
25 sices
After 90-Rotation:
26 hazard
27 shazar
28 shrines
29 shrine
30 lunts
31 blunts
32 grieves
33 grieve
34 acies
35 tracie
36 traci
37 ought
38 spasmodic
39 pasmo
40 spasm
41 malls
42 liens
43 parted
44 departed
45 parte
46 depart
47 raped
48 ashed
49 quashed
50 quash
51 hugin
52 margo
53 argos
54 clune
55 antes
56 enter
57 buffa
58 pudgiest
After 45-Rotation:
59 resor
60 roser
61 arose
62 cloven
63 clove
64 neuma
65 wifie
66 ileac
67 caeli
68 soyas
69 staun
70 cosin
71 ation
72 talos
73 talose
After 135-Rotation:
74 tallu
75 const
76 constitution
77 constitutions
78 raias
79 duddie
80 grith
81 theor
82 theorem
83 theorems
84 meroe
=cut