use Renard::Incunabula::Common::Setup;
package Intertangle::Taffeta::Graphics::Image::Imager;
# ABSTRACT: Raster data stored in Imager object

use Moo;
use Renard::Incunabula::Common::Types qw(InstanceOf);

extends qw(Intertangle::Taffeta::Graphics::Image);

=attr data

An L<Imager> image.

=cut
has data => (
	is => 'ro',
	isa => InstanceOf['Imager'],
	required => 1,
);

with qw(Intertangle::Taffeta::Graphics::Image::Role::FromCairoImageSurface);

1;
