use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Graphics::Image::Imager;
# ABSTRACT: Raster data stored in Imager object

use Moo;
use Renard::Incunabula::Common::Types qw(InstanceOf);

extends qw(Renard::Taffeta::Graphics::Image);

has data => (
	is => 'ro',
	isa => InstanceOf['Imager'],
	required => 1,
);

with qw(Renard::Taffeta::Graphics::Image::Role::FromCairoImageSurface);

1;
