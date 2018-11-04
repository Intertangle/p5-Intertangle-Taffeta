use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Graphics::Image;
# ABSTRACT: Graphics object for raster images

use Moo;

extends qw(Renard::Taffeta::Graphics);

with qw(
	Renard::Taffeta::Graphics::Role::WithBounds
);

1;
