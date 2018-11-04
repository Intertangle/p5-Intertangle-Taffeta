use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Graphics::Rectangle;
# ABSTRACT: Graphics object for raster images

use Moo;

extends qw(Renard::Taffeta::Graphics);

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

method _build_size() {
	Renard::Yarn::Graphene::Size->new(
		width => $self->width,
		height => $self->height,
	);
}

=method cairo_path

See L<Renard::Taffeta::Graphics::Role::CairoRenderable::WithCairoPath>.

=cut
method cairo_path( (CairoContext) $cr ) {
	$cr->rectangle(
		$self->origin->x,
		$self->origin->y,
		$self->width,
		$self->height,
	);
}

=method render_svg

See L<Renard::Taffeta::Graphics::Role::SVGRenderable>.

=cut
method render_svg( (SVG) $svg ) {
	$svg->rectangle(
		x => $self->origin->x,
		y => $self->origin->y,
		width => $self->width,
		height => $self->height,
		$self->svg_style_parameter,
		$self->svg_transform_parameter,
	);
}

with qw(
	Renard::Taffeta::Graphics::Role::WithBounds
	Renard::Taffeta::Graphics::Role::WithFill
	Renard::Taffeta::Graphics::Role::WithTransform
	Renard::Taffeta::Graphics::Role::WithStroke
	Renard::Taffeta::Graphics::Role::CairoRenderable::WithCairoPath
	Renard::Taffeta::Graphics::Role::SVGRenderable
	Renard::Taffeta::Graphics::Role::SVGRenderable::Style
	Renard::Taffeta::Graphics::Role::SVGRenderable::Transform
);

1;
