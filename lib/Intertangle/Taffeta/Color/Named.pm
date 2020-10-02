use Renard::Incunabula::Common::Setup;
package Intertangle::Taffeta::Color::Named;
# ABSTRACT: A named colour

use Mu;
use Renard::Incunabula::Common::Setup;
use Intertangle::Taffeta::Types qw(ColorLibrary RGB24Value);

extends qw(Intertangle::Taffeta::Color);

=attr name

The name for the color as a C<ColorLibrary> type.

This can be coerced from a string:

  Intertangle::Taffeta::Color::Named->new( name => 'svg:blue' );

=cut
has name => (
	is => 'ro',
	required => 1,
	isa => ColorLibrary,
	coerce => 1,
);

lazy value => method() {
		$self->name->value
	},
	isa => RGB24Value;

with qw(Intertangle::Taffeta::Color::Role::SVG Intertangle::Taffeta::Color::Role::RGB24Components);

# Needs to be after the role.
around _build_svg_value => fun($orig, $self) {
	if( $self->name->id =~ /^svg:/ ) {
		# if under the SVG color library
		return $self->name->name;
	} else {
		$orig->($self);
	}
};

1;
