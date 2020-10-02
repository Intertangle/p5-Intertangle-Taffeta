use Renard::Incunabula::Common::Setup;
package Intertangle::Taffeta::Graphics::Polygon;
# ABSTRACT: A segmented shape made up of points

use Moo;

extends qw(Intertangle::Taffeta::Graphics);

use Renard::Incunabula::Common::Types qw(ArrayRef);
use Intertangle::Yarn::Types qw(Point);
use Intertangle::Taffeta::Types qw(CairoContext SVG);

use List::AllUtils qw(minmax);

=attr points

An C<ArrayRef> of points.

=cut
has points => (
	is => 'ro',
	isa => ArrayRef[Point],
	required => 1,
	coerce => 1,
);

method _build_size() {
	my ($min_x, $max_x) = minmax map { $_->x } @{ $self->points };
	my ($min_y, $max_y) = minmax map { $_->y } @{ $self->points };

	Intertangle::Yarn::Graphene::Size->new(
		width => $max_x - $min_x,
		height => $max_y - $min_y,
	);
}

=method cairo_path

See L<Intertangle::Taffeta::Graphics::Role::CairoRenderable::WithCairoPath>.

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

See L<Intertangle::Taffeta::Graphics::Role::SVGRenderable>.

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
	Intertangle::Taffeta::Graphics::Role::WithBounds
	Intertangle::Taffeta::Graphics::Role::WithFill
	Intertangle::Taffeta::Graphics::Role::WithTransform
	Intertangle::Taffeta::Graphics::Role::WithStroke
	Intertangle::Taffeta::Graphics::Role::CairoRenderable::WithCairoPath
	Intertangle::Taffeta::Graphics::Role::SVGRenderable
	Intertangle::Taffeta::Graphics::Role::SVGRenderable::Style
	Intertangle::Taffeta::Graphics::Role::SVGRenderable::Transform
);

1;
