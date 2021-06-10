#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a text file. 
Write a script to display all valid phone numbers in the given text file.

Acceptable Phone Number Formats
+nn  nnnnnnnnnn (nn) nnnnnnnnnn nnnn nnnnnnnnnn

Input File

0044 1148820341
 +44 1148820341
  44-11-4882-0341
(44) 1148820341
  00 1148820341

Output

0044 1148820341
 +44 1148820341
(44) 1148820341
=cut


sub valid_phone_number
{
     my $text = $_[0];
     $text =~ s/^\s*//;
     $text =~ s/\s*$//;
     my ($code, $number) = split(/\s/, $text);
     return 0 unless defined $number;
     return 0 unless $code =~ /^\+\d{2}|\(\d{2}\)|\d{4}$/;
     return 0 unless $number =~ /\d{10}/;
     return 1;
}


while (my $line = <DATA>)
{
     chomp $line;

     print $line, $/ if valid_phone_number($line);
}



__END__
0044 1148820341
 +44 1148820341
  44-11-4882-0341
(44) 1148820341
  00 1148820341