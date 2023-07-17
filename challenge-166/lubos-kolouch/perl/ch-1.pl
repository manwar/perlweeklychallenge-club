use strict;
use warnings;

sub hex_words {
    my ($dictionary_path) = @_;
    my %hex_map =
      ( "o" => "0", "l" => "1", "i" => "1", "s" => "5", "t" => "7" );
    my $valid_chars = "abcdef" . join( "", values %hex_map );
    my @words;

    open my $fh, '<', $dictionary_path or die $!;
    while ( my $line = <$fh> ) {
        chomp $line;
        $line = lc $line;
        if (   2 <= length($line)
            && length($line) <= 8
            && $line =~ m/^[${valid_chars}]+$/ )
        {
            $line =~ s/(.)/exists($hex_map{$1}) ? $hex_map{$1} : $1/eg;
            push @words, "0x$line";
        }
    }
    close $fh;

    return @words;
}

# path to dictionary file
my $dictionary_path = "../../../data/dictionary.txt";

# get hex words
my @hex_words = hex_words($dictionary_path);

# print hex words
for my $word (@hex_words) {
    print "$word\n";
}
