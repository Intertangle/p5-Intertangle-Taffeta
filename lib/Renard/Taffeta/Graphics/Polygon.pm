use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Graphics::Polygon;
# ABSTRACT: A segmented shape made up of points

use Moo;

use Renard::Incunabula::Common::Types qw(ArrayRef);
use Renard::Yarn::Types qw(Point);
use Renard::Taffeta::Types qw(CairoContext SVG);

=attr points

An C<ArrayRef> of points.

=cut
has points => (
	is => 'ro',
	isa => ArrayRef[Point],
	required => 1,
	coerce => 1,
);

=method render_cairo

See L<Renard::Taffeta::Graphics::Role::CairoRenderable>.

=cut
method render_cairo( (CairoContext) $cr ) {
	my $create_path = sub {
		my @pts = @{ $self->points };
		$cr->move_to( $pts[0]->x, $pts[0]->y );
		for my $pt_idx (1..@pts-1, -1) {
			$cr->line_to(
				$pts[$pt_idx]->x,
				$pts[$pt_idx]->y,
			);
		}
	};

	$cr->set_matrix(
		$self->transform->cairo_matrix
	);
	if( $self->has_fill && ! $self->fill->is_fill_none ) {
		$cr->set_source_rgba(
			$self->fill->color->rgb_float_triple,
			$self->fill->opacity);

		$create_path->();
		$cr->fill;
	}
	if( $self->has_stroke && ! $self->stroke->is_stroke_none ) {
		$cr->set_line_width( $self->stroke->width );
		$cr->set_source_rgba(
			$self->stroke->color->rgb_float_triple,
			$self->stroke->opacity);

		$create_path->();
		$cr->stroke;
	}
	$cr->identity_matrix;
}


=method render_svg

See L<Renard::Taffeta::Graphics::Role::SVGRenderable>.

=cut
method render_svg( (SVG) $svg ) {
	my $style = {};

	if( $self->has_fill ) {
		$style = { %$style, %{ $self->fill->svg_style } };
	}

	if( $self->has_stroke ) {
		$style = { %$style, %{ $self->stroke->svg_style } };
	}

	my %transform_args = ();
	if( ! $self->transform->is_identity ) {
		%transform_args = (
			transform => $self->transform->svg_transform,
		);
	}

	my $path = $svg->get_path(
		x => [ map { $_->x } @{ $self->points } ],
		y => [ map { $_->y } @{ $self->points } ],
		-type => 'polygon',
	);
	$svg->polygon(
		%$path,
		style => $style,
		%transform_args,
	);
}

with qw(
	Renard::Taffeta::Graphics::Role::WithBounds
	Renard::Taffeta::Graphics::Role::WithFill
	Renard::Taffeta::Graphics::Role::WithTransform
	Renard::Taffeta::Graphics::Role::WithStroke
	Renard::Taffeta::Graphics::Role::CairoRenderable
	Renard::Taffeta::Graphics::Role::SVGRenderable
);

1;
