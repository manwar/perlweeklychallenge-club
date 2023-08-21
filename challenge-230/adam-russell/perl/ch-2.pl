use v5.38;
##
# You are given an array of positive integers.
# Write a script to separate the given array into single digits.
##
sub count_words{
    return counter(0, @_); 
}

sub counter{
    my $count = shift;
    my $prefix = shift;
    return $count if @_ == 0;
    my $word = shift;
    $count++ if $word =~ m/^$prefix/;
    counter($count, $prefix, @_);
}

MAIN:{
    say count_words qw/at pay attention practice attend/;
    say count_words qw/ja janet julia java javascript/;
}