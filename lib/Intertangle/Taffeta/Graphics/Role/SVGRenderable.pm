use Renard::Incunabula::Common::Setup;
package Intertangle::Taffeta::Graphics::Role::SVGRenderable;
# ABSTRACT: A role for an SVG renderable object

use Moo::Role;

use Intertangle::Taffeta::Types qw(SVG);
use SVG;

=method render_svg

  method render_svg( (SVG) $svg )

Renders a graphics object to a L<SVG> context.

=cut
method render_svg( (SVG) $svg ) {
	...
}

1;
