use v5.38;
##
# You are given an array of words made up of alphabetic characters and a prefix.
# Write a script to return the count of words that starts with the given prefix.
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