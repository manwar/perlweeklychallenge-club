#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script to accept an integer 1 <= N <= 5 that would print all possible strings of size N formed by using only vowels (a, e, i, o, u).
The string should follow the following rules:
    'a’ can only be followed by ‘e’ and ‘i’.
    ‘e’ can only be followed by ‘i’.
    ‘i’ can only be followed by ‘a’, ‘e’, ‘o’, and ‘u’.
    ‘o’ can only be followed by ‘a’ and ‘u’.
    ‘u’ can only be followed by ‘o’ and ‘e’.

For example, if the given integer N = 2 then script should print the following strings:
ae ai ei ia io iu ie oa ou uo ue

=cut

use Algorithm::Combinatorics qw(variations);
use Getopt::Std;

my %options=();
getopts("n:", \%options);
die "Usage: <script> -n <string length as integer>\n" unless defined $options{n};
die "Wrong string length!\n" unless ($options{n} > 1 and $options{n} < 6);

my @vowels = qw(a e i o u);

my @pos_patterns = ( qr/a[ei]/ , qr/ei/ , qr/i[aeou]/,
                 qr/o[au]/, qr/u[oe]/ );
my @neg_patterns = ( qr/a(?=[aou])/ , qr/e(?=[aeou])/ , qr/i(?=i)/,
                 qr/o(?=[eio])/, qr/u(?=[aiu])/ );
my $iter = variations(\@vowels, $options{n});

my %already_found;

VAR: while ( my $c = $iter->next )
{


     my $str = join('',@$c);

     for my $pp ( @pos_patterns )
     {
          if ( $str =~ /$pp/ )
          {
               for my $np ( @neg_patterns )
               {
                    next VAR if $str =~ /$np/;
               }
               # A string with length > 2 can match > 1 patterns.
               $already_found{$str}++; 
               print $str, $/ if 1 == $already_found{$str};
          }
     }
}