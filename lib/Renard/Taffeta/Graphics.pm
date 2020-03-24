use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Graphics;
# ABSTRACT: Base class for graphics object

use Moo;
use MooX::StrictConstructor;

with qw(
	Renard::Taffeta::Graphics::Role::CairoRenderable
	Renard::Taffeta::Graphics::Role::SVGRenderable
	Renard::Taffeta::Graphics::Role::WithTransform
);

1;
