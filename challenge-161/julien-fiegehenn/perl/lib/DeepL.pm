package DeepL;

use Moo;

use HTTP::Request::Common 'POST';
use JSON 'decode_json';
use LWP::UserAgent ();

use namespace::clean;

=head1 NAME

DeepL - Simple DeepL Translation API client

=head1 SYNOPSIS

    use DeepL;

    my $translator = DeepL->new( auth_key => $auth_key );
    my $german = $translator->translate($english);

=head1 DESCRIPTION

This module implements a very simple, naive API client for the
L<DeepL|https://www.deepl.com/docs-api/translating-text/> API. In order to
use it, you have to create a free API account. You need a credit card to
make the account.

This module accepts English text and translates to German.

=head1 ATTRIBUTES

=head2 _ua

Internal L<LWP::UserAgent> instance.

=cut

has _ua => (
  is      => 'ro',
  default => sub {
    LWP::UserAgent->new;
  }
);

=head2 auth_key

The API key. This is required. Get it from L<DeepL|https://www.deepl.com/pro>.

=cut

has auth_key => (is => 'ro', required => 1);

=head1 METHODS

=head2 translate

Translates a string C<$text> from English to German. Returns a string.

    my $german = $translator->translate($english);

=cut

sub translate {
  my ($self, $text) = @_;

  my $res = $self->_ua->request(
    POST 'https://api-free.deepl.com/v2/translate',
    [
      auth_key    => $self->auth_key,
      text        => $text,
      source_lang => 'EN',
      target_lang => 'DE',
    ]
  );
  if ($res->is_success) {
    return join '', map { $_->{text} } @{decode_json($res->content)->{translations}};
  }
}

=head1 AUTHOR

Julien Fiegehenn

=cut

1;
