use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Graphics::Role::CairoRenderable;
# ABSTRACT: A Cairo renderable graphics object

use Moo::Role;

use Renard::Taffeta::Types qw(CairoContext);

method render_cairo( (CairoContext) $cr ) {
	...
}

1;
