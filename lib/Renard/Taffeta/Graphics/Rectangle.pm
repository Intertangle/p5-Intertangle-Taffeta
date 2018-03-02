use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Graphics::Rectangle;
# ABSTRACT: Graphics object for raster images

use Moo;

use Renard::Incunabula::Common::Types qw(InstanceOf);
use Renard::Taffeta::Types qw(CairoContext SVG Dimension);

=attr width

The width of the rectangle.

=attr height

The height of the rectangle.

=cut
has [qw(width height)] => (
	is => 'ro',
	isa => Dimension,
	required => 1,
);

method _build_bounds() {
	Renard::Yarn::Graphene::Size->new(
		width => $self->width,
		height => $self->height,
	);
}

=method render_cairo

See L<Renard::Taffeta::Graphics::Role::CairoRenderable>.

=cut
method render_cairo( (CairoContext) $cr ) {
	my $create_path = sub {
		$cr->rectangle(
			$self->position->x,
			$self->position->y,
			$self->width,
			$self->height,
		);
	};
	if( $self->has_fill && ! $self->fill->is_fill_none ) {
		$cr->set_source_rgba(
			$self->fill->color->rgb_float_triple,
			$self->fill->opacity);

		$create_path->();
		$cr->fill;
	}
	if( $self->has_stroke && ! $self->stroke->is_stroke_none ) {
		$cr->set_line_width( $self->stroke->width );
		$cr->set_source_rgba(
			$self->stroke->color->rgb_float_triple,
			$self->stroke->opacity);

		$create_path->();
		$cr->stroke;
	}
}

=method render_svg

See L<Renard::Taffeta::Graphics::Role::SVGRenderable>.

=cut
method render_svg( (SVG) $svg ) {
	my $style = {};

	if( $self->has_fill ) {
		$style = { %$style, %{ $self->fill->svg_style } };
	}

	if( $self->has_stroke ) {
		$style = { %$style, %{ $self->stroke->svg_style } };
	}

	$svg->rectangle(
		x => $self->position->x,
		y => $self->position->y,
		width => $self->width,
		height => $self->height,
		style => $style,
	);
}

with qw(
	Renard::Taffeta::Graphics::Role::WithPosition
	Renard::Taffeta::Graphics::Role::WithBounds
	Renard::Taffeta::Graphics::Role::WithFill
	Renard::Taffeta::Graphics::Role::WithStroke
	Renard::Taffeta::Graphics::Role::CairoRenderable
	Renard::Taffeta::Graphics::Role::SVGRenderable
);

1;
