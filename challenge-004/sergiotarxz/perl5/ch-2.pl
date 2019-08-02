use strict;
use feature qw(say);
my @letters = split//,$ARGV[0] or die "No letters";
my $file = $ARGV[1] || '/usr/share/dict/words';
-f $file or die "The dictionary does not exists";
open my $fh, '<', $file;
my @a = <$fh>;
for (@a) {
    s/\/.*//;
    s/\n//;
    my @b = split //,$_;
    my $itsok = 1;
    my @copy = @letters;
    for (@b) {
        my $exists = 0;
        for (my $i=0;$i<@copy;$i++) {
            if ($copy[$i] =~ /$_/i) {
                $exists=1;
                splice @copy, $i, 1;
                $i--;
                last;
            }
        }
        unless ($exists) {
            $itsok = 0;
            last;
        }
    }
    $itsok and say $_;
}
