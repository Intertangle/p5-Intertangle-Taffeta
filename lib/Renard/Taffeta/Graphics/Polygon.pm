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

=method cairo_path

See L<Renard::Taffeta::Graphics::Role::CairoRenderable::WithCairoPath>.

=cut
method cairo_path( (CairoContext) $cr ) {
	my @pts = @{ $self->points };
	$cr->move_to( $pts[0]->x, $pts[0]->y );
	for my $pt_idx (1..@pts-1) {
		$cr->line_to(
			$pts[$pt_idx]->x,
			$pts[$pt_idx]->y,
		);
	}
}

=method render_svg

See L<Renard::Taffeta::Graphics::Role::SVGRenderable>.

=cut
method render_svg( (SVG) $svg ) {

	my $path = $svg->get_path(
		x => [ map { $_->x } @{ $self->points } ],
		y => [ map { $_->y } @{ $self->points } ],
		-type => 'polygon',
	);
	$svg->polygon(
		%$path,
		$self->svg_style_parameter,
		$self->svg_transform_parameter,
	);
}

with qw(
	Renard::Taffeta::Graphics::Role::WithBounds
	Renard::Taffeta::Graphics::Role::WithFill
	Renard::Taffeta::Graphics::Role::WithTransform
	Renard::Taffeta::Graphics::Role::WithStroke
	Renard::Taffeta::Graphics::Role::CairoRenderable::WithCairoPath
	Renard::Taffeta::Graphics::Role::SVGRenderable
	Renard::Taffeta::Graphics::Role::SVGRenderable::Style
	Renard::Taffeta::Graphics::Role::SVGRenderable::Transform
);

1;
