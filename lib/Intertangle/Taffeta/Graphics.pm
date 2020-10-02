use Renard::Incunabula::Common::Setup;
package Intertangle::Taffeta::Graphics;
# ABSTRACT: Base class for graphics object

use Moo;
use MooX::StrictConstructor;

with qw(
	Intertangle::Taffeta::Graphics::Role::CairoRenderable
	Intertangle::Taffeta::Graphics::Role::SVGRenderable
	Intertangle::Taffeta::Graphics::Role::WithTransform
);

1;
