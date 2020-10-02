use Renard::Incunabula::Common::Setup;
package Intertangle::Taffeta::Graphics::Rectangle;
# ABSTRACT: Graphics object for raster images

use Moo;

extends qw(Intertangle::Taffeta::Graphics);

use Intertangle::Taffeta::Types qw(CairoContext SVG Dimension);

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
	Intertangle::Yarn::Graphene::Size->new(
		width => $self->width,
		height => $self->height,
	);
}

=method cairo_path

See L<Intertangle::Taffeta::Graphics::Role::CairoRenderable::WithCairoPath>.

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

See L<Intertangle::Taffeta::Graphics::Role::SVGRenderable>.

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
	Intertangle::Taffeta::Graphics::Role::WithBounds
	Intertangle::Taffeta::Graphics::Role::WithFill
	Intertangle::Taffeta::Graphics::Role::WithTransform
	Intertangle::Taffeta::Graphics::Role::WithStroke
	Intertangle::Taffeta::Graphics::Role::CairoRenderable::WithCairoPath
	Intertangle::Taffeta::Graphics::Role::SVGRenderable
	Intertangle::Taffeta::Graphics::Role::SVGRenderable::Style
	Intertangle::Taffeta::Graphics::Role::SVGRenderable::Transform
);

1;
