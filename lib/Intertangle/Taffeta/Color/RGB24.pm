use Renard::Incunabula::Common::Setup;
package Intertangle::Taffeta::Color::RGB24;
# ABSTRACT: A 24-bit RGB colour

use Mu;
use Intertangle::Taffeta::Types qw(RGB24Value RGB24Component);

extends qw(Intertangle::Taffeta::Color);

=attr value

The 24-bit RGB value.

=cut
has value => (
	is => 'ro',
	isa => RGB24Value,
);

=method BUILDARGS

You can pass the values to the constructor as individual C<RGB24Component>s C<r8>, C<g8>, and C<b8>.

  Intertangle::Taffeta::Color::RGB24->new( r8 => 50, g8 => 25, b8 => 0 );

All 3 components must be specified at once.

=cut
around BUILDARGS => fun( $orig, $class, %args ) {
	if( exists $args{r8} && exists $args{g8} && exists $args{b8} ) {
		RGB24Component->assert_valid($args{r8});
		RGB24Component->assert_valid($args{g8});
		RGB24Component->assert_valid($args{b8});

		$args{value} = ( (delete $args{r8}) << 16 )
			+ ( (delete $args{g8}) << 8 )
			+ ( delete $args{b8} );
	}

	return $class->$orig(%args);
};

with qw(Intertangle::Taffeta::Color::Role::SVG Intertangle::Taffeta::Color::Role::RGB24Components);

1;
