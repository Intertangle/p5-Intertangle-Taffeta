use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Graphics::Rectangle;
# ABSTRACT: Graphics object for raster images

use Moo;

use Renard::Incunabula::Common::Types qw(PositiveNum);
use Renard::Taffeta::Types qw(CairoContext SVG);

=attr width

The width of the rectangle.

=attr height

The height of the rectangle.

=cut
has [qw(width height)] => (
	is => 'ro',
	isa => PositiveNum,
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
	$cr->rectangle(
		$self->position->x,
		$self->position->y,
		$self->width,
		$self->height,
	);
	$cr->fill;
}

=method render_svg

See L<Renard::Taffeta::Graphics::Role::SVGRenderable>.

=cut
method render_svg( (SVG) $svg ) {
	$svg->rectangle(
		x => $self->position->x,
		y => $self->position->y,
		width => $self->width,
		height => $self->height,
	);
}

with qw(
	Renard::Taffeta::Graphics::Role::WithPosition
	Renard::Taffeta::Graphics::Role::WithBounds
	Renard::Taffeta::Graphics::Role::CairoRenderable
	Renard::Taffeta::Graphics::Role::SVGRenderable
);

1;
