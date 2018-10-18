use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Graphics::Image;
# ABSTRACT: Graphics object for raster images

use Moo;

with qw(
	Renard::Taffeta::Graphics::Role::WithBounds
);

1;
