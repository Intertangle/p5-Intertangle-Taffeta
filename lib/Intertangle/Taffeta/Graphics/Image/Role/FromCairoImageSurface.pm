use Renard::Incunabula::Common::Setup;
package Intertangle::Taffeta::Graphics::Image::Role::FromCairoImageSurface;
# ABSTRACT: Use a Cairo image surface to render image

use Moo::Role;

use Renard::Incunabula::Common::Types qw(InstanceOf);
use Intertangle::Taffeta::Types qw(CairoContext);

has cairo_image_surface => (
	is => 'lazy', # _build_cairo_image_surface
	isa => InstanceOf['Cairo::ImageSurface'],
);

=method render_cairo

See L<Intertangle::Taffeta::Graphics::Role::CairoRenderable>.

=cut
method render_cairo( (CairoContext) $cr ) {
	$cr->save;

	$cr->set_matrix(
		$self->transform->cairo_matrix
		->multiply(
			$cr->get_matrix
		)
	);

	my $img_surface = $self->cairo_image_surface;
	$cr->set_source_surface($img_surface,
		$self->origin->x,
		$self->origin->y);
	$cr->paint;

	$cr->restore;
}

with qw(
	Intertangle::Taffeta::Graphics::Role::CairoRenderable
	Intertangle::Taffeta::Graphics::Role::WithTransform
);

1;
