#!perl

################################################################################
=comment

Perl Weekly Challenge 015
=========================

Task #3
-------

Write a script to use Language Detection API. For more information about API,
please visit [ https://detectlanguage.com/ |page]. The API task is *optional*
but we would love to see your solution.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Getopt::Long;
use JSON;
use LWP::UserAgent ();

const my $API_KEY    => '< redacted >';
const my $MAX_TEXT   =>  66;   # Max text length for 80-char console
const my $TIMEOUT    =>  30;   # seconds
const my $URL_DETECT => 'https://ws.detectlanguage.com/0.2/detect';
const my $URL_LANGS  => 'https://ws.detectlanguage.com/0.2/languages';
const my $USAGE      => "USAGE: perl $0 --help | --text <string> | " .
                                                "--file <filename>\n";

$| = 1;

MAIN:
{
    print "\n";

    my $text       = read_text();
    my $response   = get_lang_detection($text);
    my $json       = JSON->new;
    my $lang_det   = $json->decode($response)->{data}{detections}[0];
    my $confidence = $lang_det->{confidence} // 'Unknown';
    my $reliable   = $lang_det->{isReliable} ?  'Yes' : 'No';
    my $lang_code  = $lang_det->{language}   // 'Unknown';

    printf "Text:        %s\n", substr($text, 0, $MAX_TEXT);
    printf "Language:    %s = %s\n", $lang_code, get_lang_name($lang_code);
    print  "Is reliable: $reliable\n";
    print  "Confidence:  $confidence\n";
}

sub read_text
{
    my ($help, $text, $file);

    GetOptions
    (
        'help'   => \$help,
        'text:s' => \$text,
        'file:s' => \$file,

    ) or die $USAGE;

    die $USAGE if $help || ($text && $file) || (!$text && !$file);

    if ($file)
    {
        open my $fh, '<', $file
            or die "Cannot open file '$file' for reading, stopped";

        local $/;           # Slurp
        $text = <$fh>;

        close $fh
            or die "Cannot close file '$file', stopped";
    }

    return ($text);
}

sub get_lang_detection
{
    my ($text)    = @_;
    my  $ua       = LWP::UserAgent->new(timeout => $TIMEOUT);
        $ua->default_header('Authorization' => "Bearer $API_KEY");
    my  $response = $ua->post($URL_DETECT, Content => "q=$text");

{
    use Data::Dump;
    dd $response;
}
    $response->is_success
        or die $response->status_line . ', stopped';

    return $response->decoded_content;
}

sub get_lang_name
{
    my ($lang_code) = @_;

    return 'Unknown' if $lang_code eq 'Unknown';

    my $ua        = LWP::UserAgent->new(timeout => $TIMEOUT);
    my $response  = $ua->get($URL_LANGS);

    $response->is_success
        or die $response->status_line . ', stopped';

    my $content   = $response->decoded_content;
    my $json      = JSON->new;
    my $languages = $json->decode($content);
    my %languages = map { $_->{code} => $_->{name} } @$languages;

    return $languages{$lang_code};
}

################################################################################
