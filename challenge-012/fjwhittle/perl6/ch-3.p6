use Cro::HTTP::Client;

# I started this on the weekend, so don't have an API key for testing.
# Instead I've verified my assumptions using jsonplaceholder.typicode.com

#| Find synonyms for a given word using the Synonyms API from STANDS4
unit sub MAIN(
  Str $word,    #= find synonyms for this word
  Str :$uid!,   #= STANDS4 user ID
  Str :$token!, #= STANDS4 API token
);

# I think Cro should have one of these already, but couldn't find it documented
sub url-part-encode (Str $in --> Str) {
  $in.trans: <! # $ % & ' ( ) * + , / : ; = ? @ [ ]> => <%21 %23 %24 %25 %26 %27 %28 %29 %2A %2B %2C %2F %3A %3B %3D %3F %40 %5B %5D>
}

# Fill in request URI with url encoded arguments
my $uri = 'http://www.stands4.com/services/v2/syno.php?uid=%s&tokenid=%s&word=%s&format=json'.sprintf: ($uid, $token, $word).map(&url-part-encode);

# Service request is F.A.B.
my $result = await(Cro::HTTP::Client.get($uri).then({await .result.body}));

# Our service doesn't know how to use HTTP response codes.
# This bit is tested.
$result<error> and die "API responded with error ‘$result<error>’";

try {
  my $synonyms = $result<result> ~~ Array
             ??  $result<result>»<synonyms>
             !! [$result<result><synonyms>];

  $synonyms .= grep(* ~~ Str) or fail;

  say "Synonyms for ‘$word’ using the Synonyms API from STANDS4:";
  say $synonyms».split(', ').flat.unique.join(', ');
} or say "No Synonyms found for ‘$word’";

CATCH {
  when X::Cro::HTTP::Error {
    die "Error in request: ‘$_’";
  }
}
