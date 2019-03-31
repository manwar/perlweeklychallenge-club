my $string = 'Perl Weekly Challenge';
my $distance = $string ~~ tr/e/E/; # tr returns a StrDistance object
say $string;
say +$distance; # which numifies to the number of characters changed
