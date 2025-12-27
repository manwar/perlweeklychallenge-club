#! /usr/bin/env perl

use v5.36;

my @inputs = ( ["Hello world", "This is a test", "Perl is great"], ["Single"], ["Short", "This sentence has seven words in total", "A B C", "Just four words here"], ["One", "Two parts", "Three part phrase", ""], ["The quick brown fox jumps over the lazy dog", "A", "She sells seashells by the seashore", "To be or not to be that is the question"]);

foreach my $input ( @inputs ) {
    my $count = q{};
    my $lastcount = 0;
    my @sentences = @{ $input };
    foreach my $sentence ( @sentences ) {
        $count = scalar( split( /\s/, $sentence ) );
	$lastcount = $count if $count > $lastcount;
    }
    print "Input: \@sentences = (", join( ", ", @sentences ), ")\n";
    print "Output: $lastcount\n\n";
}

__END__
