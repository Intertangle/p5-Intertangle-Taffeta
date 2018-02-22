use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Style::Stroke;
# ABSTRACT: Stroke style

use Moo;
use Renard::Taffeta::Types qw(Color Opacity Dimension);

has opacity => (
	is => 'ro',
	predicate => 1,
	default => sub { 1 },
	isa => Opacity,
);

has color => (
	is => 'ro',
	predicate => 1,
	isa => Color,
);

has width => (
	is => 'ro',
	predicate => 1,
	default => sub { 1 },
	isa => Dimension,
);

method is_stroke_none() {
	return ! $self->has_color && ! $self->has_opacity;
}

method svg_style() {
	my $data = {};

	if( $self->is_stroke_none ) {
		$data->{stroke} = 'none';
	} elsif( $self->has_color ) {
		$data->{stroke} = $self->color->svg_value;
	}

	if( $self->has_opacity ) {
		$data->{'stroke-opacity'} = $self->opacity;
	}

	if( $self->has_width ) {
		$data->{'stroke-width'} = $self->width;
	}

	$data;
}

1;
