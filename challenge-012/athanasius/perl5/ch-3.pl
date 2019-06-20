#!perl

################################################################################
=comment

Perl Weekly Challenge 012
=========================

Challenge #3
------------

Find out the synonyms of a given word using the
[ https://www.synonyms.com/synonyms_api.php |Synonyms API]. The API challenge is
optional but would love to see your solution.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 Perlmonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use LWP::UserAgent ();
use XML::LibXML;

const my $DEFAULT => 'consistent';
const my $FORMAT  => 'xml';
const my $TOKENID => '< redacted >';
const my $TIMEOUT =>  30;     # seconds
const my $UID     => '< redacted >';
const my $URL     => 'http://www.stands4.com/services/v2/syno.php?';

$| = 1;

MAIN:
{
    my $word     = $ARGV[0] // $DEFAULT;
    my $response = get_synonyms($word);
    my $entries  = parse_xml($response);

    print "\nResults for the word \"$word\":\n";

    if (scalar @$entries > 0)
    {
        my $n = 1;

        for my $entry (@$entries)
        {
            printf "\nDefinition %d:\n%s\n\nSynonyms:\n%s\n",
                    $n++, $entry->[0], $entry->[1];
        }
    }
    else
    {
        print "No nodes found\n";
    }
}

sub get_synonyms
{
    my ($word)    =  @_;
    my  $url      = "${URL}uid=$UID&tokenid=$TOKENID&word=$word&format=$FORMAT";
    my  $ua       =  LWP::UserAgent->new(timeout => $TIMEOUT);
    my  $response =  $ua->get($url);

    $response->is_success
        or die $response->status_line . ', stopped';

    return $response->decoded_content;
}

sub parse_xml
{
    my ($xml) = @_;
    my  $dom  = XML::LibXML->load_xml(string => $xml);
    my  @entries;

    if (my @nodes = $dom->findnodes('/results/result'))
    {
        for my $node (@nodes)
        {
            my @defs = $node->findnodes('./definition');
            my @syns = $node->findnodes('./synonyms');

            if (scalar @defs == 1 &&
                scalar @syns == 1)
            {
                push @entries, [ $defs[0]->to_literal,
                                 $syns[0]->to_literal || '(none found)' ];
            }
            else
            {
                die 'Node error, stopped';
            }
        }
    }

    return \@entries;
}

################################################################################

