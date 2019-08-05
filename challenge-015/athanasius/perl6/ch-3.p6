use v6;

################################################################################
=begin comment

Perl Weekly Challenge 015
=========================

Task #3
-------

Write a script to use Language Detection API. For more information about API,
please visit [ https://detectlanguage.com/ |page]. The API task is *optional*
but we would love to see your solution.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use JSON::Tiny;
use LWP::UserAgent:from<Perl5> ();

my Str  constant $API-KEY    = '< redacted >';
my UInt constant $MAX-TEXT   =  66;   # max text length for 80-char console
my UInt constant $TIMEOUT    =  30;   # seconds
my Str  constant $URL-DETECT = 'https://ws.detectlanguage.com/0.2/detect';
my Str  constant $URL-LANGS  = 'https://ws.detectlanguage.com/0.2/languages';

sub MAIN
(
    Bool :$help,    #= this usage message
    Str  :$text,    #= text with language to be detected
    Str  :$file,    #= name of file containing text with language to be detected
)
{
	say '';
    die $*USAGE if $help || ($text && $file) || (!$text && !$file);

    my utf8 $target     = $file ?? $file.IO.slurp.encode('UTF-8')
                                !! $text.encode('UTF-8');
    my Str  $response   = get-lang-detection($target);
    my      %lang-det   = from-json($response){'data'}{'detections'}[0];
    my Rat  $confidence = %lang-det{'confidence'} // 'Unknown';
    my Str  $reliable   = %lang-det{'isReliable'} ??  'Yes' !! 'No';
    my Str  $lang-code  = %lang-det{'language'}   // 'Unknown';

    say 'Text:        ', $target.decode.substr(0, $MAX-TEXT);
    say 'Language:    ', $lang-code, ' = ', get-lang-name($lang-code);
    say 'Is reliable: ', $reliable;
    say 'Confidence:  ', $confidence;

    CATCH
    {
        default
        {
            .payload.say;
        }
    };
}

sub get-lang-detection(utf8:D $text --> Str)
{
    my $ua = LWP::UserAgent.new(timeout => $TIMEOUT);
       $ua.default_header('Authorization' => "Bearer $API-KEY");
    my $response = $ua.post($URL-DETECT, Content => "q=$text");

    $response.is_success
        or die $response.status_line ~ ', stopped';

    return $response.decoded_content;
}

sub get-lang-name(Str:D $lang-code --> Str)
{
    return 'Unknown' if $lang-code eq 'Unknown';

    my $ua       = LWP::UserAgent.new(timeout => $TIMEOUT);
    my $response = $ua.get($URL-LANGS);

    $response.is_success
        or die $response.status_line ~ ', stopped';

    my $content   = $response.decoded_content;
    my $languages = from-json($content);
    my %languages = $languages.map: { $_{'code'} => $_{'name'} };

    return %languages{$lang-code};
}

################################################################################
