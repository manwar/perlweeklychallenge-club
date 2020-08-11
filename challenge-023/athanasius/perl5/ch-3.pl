#!perl

################################################################################
=comment

Perl Weekly Challenge 023
=========================

Task #3
-------
Write a script to use *Random Poems API*. This is the easiset API, I have come
across so far. You don't need API key for this. They have only
[ https://www.poemist.com/api/v1/randompoems |route] to work with (GET). The API
task is *optional* but we would love to see your solution.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use feature qw( state );
use Const::Fast;
use JSON::XS;
use LWP::Simple;
use Tk;
use Tk::ROText;

const my $BUTTON_FONT => 'Ariel 8';
const my $POEM_FONT   => 'Ariel 16';
const my $TITLE       => 'Random Poems from Poemist';
const my $URL         => 'https://www.poemist.com/api/v1/randompoems';

#===============================================================================
MAIN:
#===============================================================================
{
    my $main = MainWindow->new(-title => $TITLE);
       $main->optionAdd('*font', $POEM_FONT);

    my $text = make_text_widget($main);

    make_next_button($main, $text);

    MainLoop();
}

#-------------------------------------------------------------------------------
sub make_text_widget
#-------------------------------------------------------------------------------
{
    my ($main) = @_;
    my  $text  = $main->Scrolled
                 (
                     'ROText',
                     -borderwidth =>  2,
                     -setgrid     => 'true',
                     -height      =>  30,
                     -width       =>  60,
                     -scrollbars  => 'oe',
                     -state       => 'normal',
                     -wrap        => 'word',
                 )
                 ->pack
                 (
                     -expand      => 'yes',
                     -fill        => 'both',
                 );
        $text->insert
                 (
                     '0.0',
                      get_next_poem(),
                 );

    return $text;
}

#-------------------------------------------------------------------------------
sub make_next_button
#-------------------------------------------------------------------------------
{
    my ($main, $text) = @_;

    $main->Button
           (
               -text    => 'Next Poem',
               -font    =>  $BUTTON_FONT,
               -command =>  sub
                            {
                                $text->delete('0.0', 'end');
                                $text->insert('0.0',  get_next_poem());
                            },
           )
           ->pack
           (
               -side   => 'top',
               -expand => 'yes',
               -pady   =>  2,
           );
}

#-------------------------------------------------------------------------------
sub get_next_poem
#-------------------------------------------------------------------------------
{
    state @poems;

    @poems = get_poems() until scalar @poems;

    return shift @poems;
}

#-------------------------------------------------------------------------------
sub get_poems
#-------------------------------------------------------------------------------
{
    my @poems;
    my $json    = get($URL);
    my @entries = decode_json($json);

    scalar @entries == 1
        or die "Wrong number of entries: " . scalar(@entries) . "\n";

    for my $poem ( $entries[0]->@* )
    {
        my $content = $poem->{content};

        if (defined $content && $content ne '')
        {
            my $title = $poem->{title};
            my $poet  = $poem->{poet}{name};

            for ($title, $poet)
            {
                s/ ^ \s+   //x;
                s/   \s+ $ //x;
            }

            $title = '"' . $title . '"' unless substr($title, 0, 1) eq '"';

            push @poems, sprintf "%s by %s\n\n%s", $title, $poet, $content;
        }
    }

    return @poems;
}

################################################################################
