use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Style::Fill;
# ABSTRACT: Fill style

use Moo;
use Renard::Incunabula::Common::Types qw(Bool);
use Renard::Taffeta::Types qw(Color Opacity Dimension);

=attr opacity

The C<Opacity> for the fill.

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

The C<Color> for the fill.

=method has_color

Predicate for the C<color> attribute.

=cut
has color => (
	is => 'ro',
	predicate => 1,
	isa => Color,
);

=method is_fill_none

Returns a C<Bool> for if the fill is empty.

=cut
method is_fill_none() :ReturnType(Bool) {
	return ! $self->has_color && ! $self->has_opacity;
}

=method svg_style

Returns a C<HashRef> that represents the SVG style for this fill.

=cut
method svg_style() {
	my $data = {};

	if( $self->is_fill_none ) {
		$data->{fill} = 'none';
	} elsif( $self->has_color ) {
		$data->{fill} = $self->color->svg_value;
	}

	if( $self->has_opacity ) {
		$data->{'fill-opacity'} = $self->opacity;
	}

	$data;
}

1;
