use strict;
use warnings;
use feature qw/say/;
use Storable;
use Data::Dumper;

die "Please pass two words as parameters" unless @ARGV == 2;
my ($word1, $word2)= @ARGV;
my $length = length $word1;
die "The two words must have the same length\n" if $length != length $word2;

my $store_file = "word_store_$length";
my ($store_ref, %words);
if (-e $store_file) {
    my $store_ref = retrieve($store_file);
    %words = %$store_ref;
} else {
    my $file = "words$length.txt";
    open my $IN, '<', $file or die "Cannot open $file$!";
    while (my $word = <$IN>) {
        chomp $word;
        $words{$word} = [];
        for my $key (keys %words) {
            if (edit_distance($key, $word) == 1) {
                push @{$words{$key}}, $word;
                push @{$words{$word}}, $key;
            }
        }
    }
    close $IN;
    my $orphans = "aloof_$length.txt";
    open my $OUT, ">", $orphans or die "Cannot open file $orphans$!";
    for my $key (keys %words){
        if (scalar keys $words{$key} == 0) {
            say $OUT "$key";
            delete $words{$key};
        }
    }
    close $OUT;
    store \%words, $store_file;
}

my $max = $le   ngth * 2;

sub edit_distance {
    my ($word1, $word2) = @_;
    # die "Words $word1 and $word2 ..." -> No longer needed as this is checked before
    my @w1 = split //, $word1;
    my @w2 = split //, $word2;
    my $dist = 0;
    for my $i (0..$#w1) {
        $dist++ if $w1[$i] ne $w2[$i];
    }
    return $dist;
}

sub ladder {
    my ($word1, $word2, $tmp_result) = @_;
    return $tmp_result if $word1 eq $word2;
    return [] if scalar @$tmp_result >= $max;
    my @temp_solutions;
    for my $word (@{$words{$word1}}) {
        next if $word eq $word1;
        next if grep { $_ eq $word } @$tmp_result; # not really needed but a bit faster
        push @temp_solutions, [@$tmp_result, $word] and last if $word eq $word2;
        my $new_tmp = ladder($word, $word2, [@$tmp_result, $word]);
        next if scalar @$new_tmp == scalar @$tmp_result;
        next unless scalar @$new_tmp;
        push @temp_solutions, $new_tmp;
    }
    return [] unless @temp_solutions;
    my $best_sol = (sort { scalar @$a <=> scalar @$b } @temp_solutions)[0];
    $max = scalar @$best_sol if scalar @$best_sol < $max;
    return $best_sol;
}

for ($word1, $word2) {
    die "Word $_ not found\n" unless exists $words{$_};
}
my $ladder = ladder $word1, $word2, [$word1];

if (@$ladder) {
    say join "->", @$ladder;
} else {
    say "No ladder found for $word1 and $word2"
}
