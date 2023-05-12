#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

&main;

sub main {
    my @stickers=('perl','raku','python');
    my $word='peon';
    my $count=&how_many(\@stickers,$word);    
    print "Output: $count\n";

    @stickers=('love','hate','angry');
    $word='goat';
    $count=&how_many(\@stickers,$word);    
    print "Output: $count\n";

    @stickers=('come','nation','delta');
    $word='accomodation';
    $count=&how_many(\@stickers,$word);    
    print "Output: $count\n";

    @stickers=('come','country','delta');
    $word='accomodation';
    $count=&how_many(\@stickers,$word);    
    print "Output: $count\n";
}

sub how_many {
    my $stickers=shift;
    my $word=shift;

    my %sticker_hash=();
    
    foreach my $sticker (@$stickers) {
        foreach my $letter (split//,$sticker) {
            push @{$sticker_hash{$sticker}{'letters'}},$letter;
        }
    }

    my @letters=split//,$word;

    for(my $i=0;$i<scalar(@letters);$i++) {
        my $found=0;
        foreach my $sticker (@$stickers) {
            if (grep(/$letters[$i]/,@{$sticker_hash{$sticker}{'letters'}})) {
                push @{$sticker_hash{$sticker}{'needed_letters'}},$letters[$i];
                $found=1;
                last;
            }
        }
        if ($found == 0) {
            return 0;
        }
    }

    
    my $sticker_count=0;
    foreach my $word (%sticker_hash) {
        if (exists($sticker_hash{$word}{'needed_letters'}) and scalar(@{$sticker_hash{$word}{'needed_letters'}}) > 0) {
            $sticker_count++;
            if (scalar(@{$sticker_hash{$word}{'needed_letters'}}) > length($word)) {
                $sticker_count++;     
            }
        }
    }
    return $sticker_count;
}
