#!/usr/bin/perl

# A properly modularized version of this script will be uploaded to CPAN soon.

package WWW::Bhagavadgita::Chapter;

use Moo;
use namespace::clean;

has [qw/
        chapter_number
        chapter_summary
        name
        name_meaning
        name_translation
        name_transliterated
        verses_count
    /] => (
    is       => 'ro',
    required => 1
);

1; # End of WWW::Bhagavadgita::Chapter

package WWW::Bhagavadgita::Verse;

use Moo;
use namespace::clean;

has [qw/
        meaning
        text
        transliteration
        verse_number
        word_meanings
    /] => (
    is       => 'ro',
    required => 1
);

1; # End of WWW::Bhagavadgita::Verse

package WWW::Bhagavadgita;

use Moo;
use HTTP::Request::Common qw/ GET POST /;
use JSON qw/ decode_json /;
use LWP::UserAgent;
use WWW::Bhagavadgita::Chapter;
use WWW::Bhagavadgita::Verse;
use utf8;
use namespace::clean;

has [qw/ client_id  client_secret /] => (
    is       => 'ro',
    required => 1
);

has token => (
    is => 'rw',
);

has ua => (
    is  => 'lazy',
);

sub _build_ua {
    my ($self) = @_;

    my $ua = LWP::UserAgent->new(
        # bhagavadgita.io blocks user agents it doesn't recognize so let's
        # pretend to be cUrl.
        agent => "curl/7.58.0",
    );
    $ua->default_header( 'Accept' => 'application/json' );

    return $ua;
}

sub _get_token {
    my ($self) = @_;

    my $request = POST(
        'https://bhagavadgita.io/auth/oauth/token',
        [
            client_id     => $self->client_id,
            client_secret => $self->client_secret,
            grant_type    => 'client_credentials',
            scope         => 'verse chapter',
        ],
        Content_Type  => 'application/x-www-form-urlencoded',
    );

    my $response = $self->ua->request($request);
    if ($response->is_success) {
        my $results = decode_json($response->decoded_content);
        $self->token($results->{access_token});
    } else {
        $self->token(undef);
    }
}


sub _call {
    my ($self, @args) = @_;
    my $url = 'https://bhagavadgita.io/api/v1/';

    if (scalar @args) {
        $url .= join(q{/}, @args);

    } else {
        return { error => "Not enough arguments." };

    }

    $self->token // $self->_get_token();
    if (!defined $self->token) {
        return { error => "Couldn't get auth token." };
    }

    my $request = GET($url,
       authorization => 'Bearer ' . $self->token
    );

    my $response = $self->ua->request($request);
    if ($response->is_success) {
        return { data => $response->decoded_content };
    } else {
        return { error => $response->status_line };
    }
    
}

=head2 chapters()

Get all the 18 Chapters of the Bhagavad Gita.

Returns an array of L<WWW::Bhagavadgita::Chapter> objects or undef if there
has been an error.

=cut

sub chapters {
    my ($self) = @_;

    my $result = $self->_call('chapters');

    if (defined $result->{error}) {
        return undef;
    } else {
        my @chapters;
        for my $chapter (@{ decode_json( $result->{data} ) }) {
            push @chapters, WWW::Bhagavadgita::Chapter->new($chapter);
        };
        return @chapters;
    }
}

=head2 chapter($chapter_number)

Get a specific chapter from the Bhagavad Gita.

Returns a L<WWW::Bhagavadgita::Chapter> object or undef if there
has been an error.

=cut

sub chapter {
    my ($self, $chapter_number) = @_;

    my $result = $self->_call('chapters', $chapter_number);

    if (defined $result->{error}) {
        return undef;
    } else {
        return WWW::Bhagavadgita::Chapter->new(decode_json($result->{data}));
    }
}

=head2 verses()

Get all the verses in the Bhagavad Gita.

Returns an array of L<WWW::Bhagavadgita::Verse> objects or undef if there
has been an error.

=cut

sub verses {
    my ($self) = @_;

    my $result = $self->_call('verses');

    if (defined $result->{error}) {
        return undef;
    } else {
        my @verses;
        for my $verse (@{ decode_json( $result->{data} ) }) {
            push @verses, WWW::Bhagavadgita::Verse->new($verse);
        };
        return @verses;
    }
}

=head2 verse($chapter_number, $verse_number)

Get a particular verse from a chapter.

Returns a L<WWW::Bhagavadgita::Verse> object or undef if there
has been an error.

=cut

sub verse {
    my ($self, $chapter_number, $verse_number) = @_;

    my $result =
        $self->_call('chapters', $chapter_number, 'verses', $verse_number);

    if (defined $result->{error}) {
        return undef;
    } else {
        return WWW::Bhagavadgita::Verse->new(decode_json($result->{data}));
    }
}

=head2 chapter_verses($chapter_number)

Get all the Verses from a Chapter.

Returns an array of L<WWW::Bhagavadgita::Verse> objects or undef if there
has been an error.

=cut

sub chapter_verses {
    my ($self, $chapter_number, $verse_number) = @_;

    my $result =
        $self->_call('chapters', $chapter_number, 'verses');

    if (defined $result->{error}) {
        return undef;
    } else {
        my @verses;
        for my $verse (@{ decode_json( $result->{data} ) }) {
            push @verses, WWW::Bhagavadgita::Verse->new($verse);
        };
        return @verses;
    }
}
1; # End of WWW::Bhagavadgita

package main;
use 5.010;

binmode STDOUT, ':utf8';

my $bg  = WWW::Bhagavadgita->new(
    client_id     => "YOUR CLIENT ID",
    client_secret => "YOUR CLIENT SECRET"
);

for my $chapter ($bg->chapters) {
    say $chapter->name_translation;
}

say "\n", $bg->chapter(2)->chapter_summary, "\n";

say $bg->verse(18, 66)->transliteration;

# etc...