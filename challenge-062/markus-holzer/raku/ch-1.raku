class Mail
{
	has Str $.adress;
	has Str $.domain;
	has Str $.mailbox;
	has Str $.norm;

	submethod TWEAK( :$!adress )
	{
		my $index = $!adress.index: '@';

		$!mailbox = $!adress.substr( 0, $index );
		$!domain  = $!adress.substr( $index + 1, * ).lc;
		$!norm    = $!mailbox ~ '@' ~ $!domain;		
	}

	method gist() {
		$.norm 	}

	method Str() {
		$.adress }
}

multi sub MAIN( :$u ) {
	output-email-adresses $u, sort-mail-adresses $*IN }

multi sub MAIN( :$u, *@args ) {
	output-email-adresses $u, sort-mail-adresses @args.map: *.IO.open( :r ) }

sub output-email-adresses( $unique, @things ) {
	.Str.say for $unique ?? @things.unique( :as( *.norm ) ) !! @things } 

sub sort-mail-adresses( *@handles ) 
{
	my &adress = -> $adress { Mail.new( :$adress ) };	 
	my &sort   = -> $a, $b  { $a.domain cmp $b.domain || $a.mailbox cmp $b.mailbox };

	@handles
		.map( *.lines )
		.flat
		.map( &adress )
		.sort( &sort )
}