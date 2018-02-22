package Renard::Taffeta::Color::Named;
# ABSTRACT: A named colour

use Mu;
use Renard::Incunabula::Common::Setup;
use Renard::Taffeta::Types qw(ColorLibrary RGB24Value);

extends qw(Renard::Taffeta::Color);

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

with qw(Renard::Taffeta::Color::Role::SVG Renard::Taffeta::Color::Role::RGB24Components);

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
