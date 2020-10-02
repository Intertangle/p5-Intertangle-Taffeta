use Renard::Incunabula::Common::Setup;
package Intertangle::Taffeta::Graphics::Role::SVGRenderable::Transform;
# ABSTRACT: Role for SVG transform parameters

use Moo::Role;

requires 'transform';

=method svg_transform_parameter

Returns transform parameter for SVG based on transform attribute.

=cut
method svg_transform_parameter() {
	my %transform_args = ();
	if( ! $self->transform->is_identity ) {
		%transform_args = (
			transform => $self->transform->svg_transform,
		);
	}

	return %transform_args;
}

1;
