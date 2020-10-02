use Renard::Incunabula::Common::Setup;
package Intertangle::Taffeta::Graphics::Role::CairoRenderable::WithCairoPath;
# ABSTRACT: A role to help draw a Cairo path with styles/transformations

use Moo::Role;
use Intertangle::Taffeta::Types qw(CairoContext);

=method cairo_path

  method cairo_path( (CairoContext) $cr )

Draws a path using Cairo. This needs to implemented by role consumers.

=cut
method cairo_path( (CairoContext) $cr ) {
	...
}


=method render_cairo

See L<Intertangle::Taffeta::Graphics::Role::CairoRenderable>.

=cut
method render_cairo( (CairoContext) $cr ) {
	$cr->save;

	$cr->set_matrix(
		$self->transform->cairo_matrix
	);

	if( $self->has_fill && ! $self->fill->is_fill_none ) {
		$cr->set_source_rgba(
			$self->fill->color->rgb_float_triple,
			$self->fill->opacity);

		$self->cairo_path( $cr );
		$cr->fill;
	}
	if( $self->has_stroke && ! $self->stroke->is_stroke_none ) {
		$cr->set_line_width( $self->stroke->width );
		$cr->set_source_rgba(
			$self->stroke->color->rgb_float_triple,
			$self->stroke->opacity);

		$self->cairo_path( $cr );
		$cr->stroke;
	}

	$cr->restore;
}

with qw(
	Intertangle::Taffeta::Graphics::Role::CairoRenderable
);

1;
