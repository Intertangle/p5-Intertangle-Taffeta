use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Color::RGB24;
# ABSTRACT: A 24-bit RGB colour

use Mu;
use Renard::Taffeta::Types qw(RGB24Value);

extends qw(Renard::Taffeta::Color);

has value => (
	is => 'ro',
	isa => RGB24Value,
);

around BUILDARGS => fun( $orig, $class, %args ) {
	if( exists $args{r} && exists $args{g} && exists $args{b} ) {
		$args{value} = (delete $args{r}) << 16
			+ (delete $args{g}) << 8
			+ (delete $args{b});
	}

	return $class->$orig(%args);
};

with qw(Renard::Taffeta::Color::Role::SVG Renard::Taffeta::Color::Role::RGB24Components);

1;
