use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Graphics::Image::CairoImageSurface;
# ABSTRACT: Render a Cairo image surface

use Moo;

use Renard::Incunabula::Common::Types qw(InstanceOf);
use Renard::Taffeta::Types qw(CairoContext);

extends qw(Renard::Taffeta::Graphics::Image);

has cairo_image_surface => (
	is => 'ro',
	isa => InstanceOf['Cairo::ImageSurface'],
);

with qw(Renard::Taffeta::Graphics::Image::Role::FromCairoImageSurface);

1;
