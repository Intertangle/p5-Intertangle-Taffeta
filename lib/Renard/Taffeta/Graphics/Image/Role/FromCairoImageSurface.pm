use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Graphics::Image::Role::FromCairoImageSurface;
# ABSTRACT: Use a Cairo image surface to render image

use Moo::Role;

use Renard::Incunabula::Common::Types qw(InstanceOf);
use Renard::Taffeta::Types qw(CairoContext);

has cairo_image_surface => (
	is => 'lazy', # _build_cairo_image_surface
	isa => InstanceOf['Cairo::ImageSurface'],
);

=method render_cairo

See L<Renard::Taffeta::Graphics::Role::CairoRenderable>.

=cut
method render_cairo( (CairoContext) $cr ) {
	my $img_surface = $self->cairo_image_surface;
	$cr->set_source_surface($img_surface,
		$self->position->x,
		$self->position->y);
	$cr->paint;
}

with qw(Renard::Taffeta::Graphics::Role::CairoRenderable);

1;
