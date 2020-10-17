use Renard::Incunabula::Common::Setup;
package Intertangle::Taffeta::Graphics::Image::CairoImageSurface;
# ABSTRACT: Render a Cairo image surface

use Moo;

use Renard::Incunabula::Common::Types qw(InstanceOf);
use Intertangle::Taffeta::Types qw(CairoContext);

extends qw(Intertangle::Taffeta::Graphics::Image);

=attr cairo_image_surface

A L<Cairo> image surface.

=cut
has cairo_image_surface => (
	is => 'ro',
	isa => InstanceOf['Cairo::ImageSurface'],
);

with qw(Intertangle::Taffeta::Graphics::Image::Role::FromCairoImageSurface);

1;
