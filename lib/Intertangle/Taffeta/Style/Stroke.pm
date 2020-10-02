use Renard::Incunabula::Common::Setup;
package Intertangle::Taffeta::Style::Stroke;
# ABSTRACT: Stroke style

use Moo;
use Renard::Incunabula::Common::Types qw(Bool);
use Intertangle::Taffeta::Types qw(Color Opacity Dimension);

=attr opacity

The C<Opacity> for the stroke.

=method has_opacity

Predicate for C<opacity> attribute.

=cut
has opacity => (
	is => 'ro',
	predicate => 1,
	default => sub { 1 },
	isa => Opacity,
);

=attr color

The C<Color> for the stroke.

=method has_color

Predicate for the C<color> attribute.

=cut
has color => (
	is => 'ro',
	predicate => 1,
	isa => Color,
);

=attr width

A C<Dimension> for the width of the stroke line.

=method has_width

Predicate for C<width> attribute.

=cut
has width => (
	is => 'ro',
	predicate => 1,
	default => sub { 1 },
	isa => Dimension,
);

=method is_stroke_none

Returns a C<Bool> for if the stroke is empty.

=cut
method is_stroke_none() :ReturnType(Bool) {
	return ! $self->has_color && ! $self->has_opacity;
}

=method svg_style

Returns a C<HashRef> that represents the SVG style for this stroke.

=cut
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
