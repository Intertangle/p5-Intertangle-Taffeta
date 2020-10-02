use Renard::Incunabula::Common::Setup;
package Intertangle::Taffeta::Graphics::Image;
# ABSTRACT: Graphics object for raster images

use Moo;

extends qw(Intertangle::Taffeta::Graphics);

with qw(
	Intertangle::Taffeta::Graphics::Role::WithBounds
);

1;
