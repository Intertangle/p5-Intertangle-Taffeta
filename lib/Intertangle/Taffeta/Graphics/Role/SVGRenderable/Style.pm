use Renard::Incunabula::Common::Setup;
package Intertangle::Taffeta::Graphics::Role::SVGRenderable::Style;
# ABSTRACT: Role for style SVG parameters

use Moo::Role;

requires 'fill';
requires 'stroke';

=method svg_style_parameter

Returns style parameter for SVG based on fill and stroke style attributes.

=cut
method svg_style_parameter() {
	my $style = {};

	if( $self->has_fill ) {
		$style = { %$style, %{ $self->fill->svg_style } };
	}

	if( $self->has_stroke ) {
		$style = { %$style, %{ $self->stroke->svg_style } };
	}

	return ( style => $style );
}

1;
