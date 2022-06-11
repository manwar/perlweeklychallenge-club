use strict;
use warnings;
##
# Using the provided dictionary generate at least one pangram.
##
use Lingua::EN::Tagger;

sub pangram{
    my %tagged_words;
    my $tagger = new Lingua::EN::Tagger;
    for my $word (@_){
        chomp($word);
        my $tagged_text = $tagger->add_tags($word);
        $tagged_text =~ m/<([a-z]*)>([a-z]*<)/;
        my $tag = $1;
        if($tagged_words{$tag}){
            push @{$tagged_words{$tag}}, $word;
        }
        else{
            $tagged_words{$tag} = [$word];
        }
    }
    ##
    # generate sentences from random words in a (somewhat) grammatical way
    ##
    my $sentence;
    my @dets = @{$tagged_words{det}};
    my @adjs = @{$tagged_words{jj}};
    my @nouns = @{$tagged_words{nn}};
    my @verbs = @{$tagged_words{vb}};
    my @cons = @{$tagged_words{cc}};
    my @adverbs = @{$tagged_words{vb}};
    do{
        my $det0 = $dets[rand @dets];
        my $adj0 = $adjs[rand @adjs];
        my $noun = $nouns[rand @nouns];
        my $verb = $verbs[rand @verbs];
        my $det1 = $dets[rand @dets];
        my $adj1 = $adjs[rand @adjs];
        my $object0 = $nouns[rand @nouns];
        my $conj = $cons[rand @cons];
        my $det2 = $dets[rand @dets];
        my $adj2 = $adjs[rand @adjs];
        my $object1 = $nouns[rand @nouns];
        my $adverb = $adverbs[rand @adverbs];
        my %h;
        for my $c (split(//, "$det0$adj0$noun$verb$det1$adj1$object0$conj$det2$adj2$object1")){
            $h{$c} = undef;
        }
        $sentence = "$det0 $adj0 $noun $verb $det1 $adj1 $object0 $conj $det2 $adj2 $object1" if keys %h == 26;        
    }while(!$sentence);
    return $sentence;
}

MAIN:{
    open(DICTIONARY, "dictionary");
    print pangram(<DICTIONARY>) . "\n";
    close(DICTIONARY);
}