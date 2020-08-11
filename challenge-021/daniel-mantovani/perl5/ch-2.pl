# Write a script for URL normalization based on rfc3986.
# This task was shared by Anonymous Contributor.
#
# According to Wikipedia, URL normalization is the process by which URLs are modified
# and standardized in a consistent manner. The goal of the normalization process is to
# transform a URL into a normalized URL so it is possible to determine if two
# syntactically different URLs may be equivalent.

use strict;
use warnings;
use v5.10;

# After reading over RFC 3968, I think is much better to use a good module from CPAN
# for this kind of job. There are just too many cases to consider, so reinventing
# the wheel doesn't seem to be a good option here.
#
# There are two modules that catch my attention for RFC 3986 normalization:
# URI::Normalize
# URL::Normalize
#
# last one is heavier on dependences than the former, but I see it allows
# much more flexibility to fine tune the desired normalization

use URL::Normalize;

my $in = shift;    # get url from command line
die "Usage: perl $0 <url-to-be-normalized>" unless $in;

# first we initialize our normalizer with input url
my $normalizer = URL::Normalize->new($in);

# now we start to apply some normalizations.
# some methods just have an obvious meaning
$normalizer->remove_dot_segments;
$normalizer->remove_duplicate_slashes;
$normalizer->sort_query_parameters;
$normalizer->remove_duplicate_query_parameters;
$normalizer->remove_empty_query_parameters;

# The "make_canonical" method, involves several important steps like
# convert scheme & host to lower case, capitalize escape seqs,
# decode all unreserved chars, and remove default port when possible

$normalizer->make_canonical;

# and that's it, now we just print the normalized result:
say $normalizer->url;

# There are a lot of very interestin methods on this module, that will
# allow to normalize removing several parameters that will not really
# change the content we will get using the url.

# Please take a look at https://metacpan.org/pod/URL::Normalize for
# further information on the module used
