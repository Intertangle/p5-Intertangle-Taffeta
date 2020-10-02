use Renard::Incunabula::Common::Setup;
package Intertangle::Taffeta::Graphics::Image::PNG;
# ABSTRACT: Raster data stored in PNG format

use Moo;
use Renard::Incunabula::Common::Types qw(Str InstanceOf Int);
use Intertangle::Taffeta::Types qw(SVG);
use MIME::Base64;
use Image::Size;

extends qw(Intertangle::Taffeta::Graphics::Image);

=attr data

A C<Str> that contains the PNG binary data.

=cut
has data => (
	is => 'ro',
	isa => Str,
	required => 1,
);

method _build_cairo_image_surface() :ReturnType(InstanceOf['Cairo::ImageSurface']) {
	# read the PNG data in-memory
	my $img = Cairo::ImageSurface->create_from_png_stream(
		fun ((Str) $callback_data, (Int) $length) {
			state $offset = 0;
			my $data = substr $callback_data, $offset, $length;
			$offset += $length;
			$data;
		}, $self->data );

	return $img;
}

method _build_size() :ReturnType(InstanceOf['Intertangle::Yarn::Graphene::Size']) {
	my ($width, $height, $id_or_error) = Image::Size::imgsize( \($self->data) );
	die "Could not compute bounds: $id_or_error" unless $id_or_error eq 'PNG';
	Intertangle::Yarn::Graphene::Size->new(
		width => $width,
		height => $height,
	);
}

=method render_svg

See L<Intertangle::Taffeta::Graphics::Role::SVGRenderable>.

=cut
method render_svg( (SVG) $svg ) {
	$svg->image(
		x => $self->origin->x,
		y => $self->origin->y,
		'-href' => "data:image/png;base64,@{[ encode_base64( $self->data ) ]}",
		$self->svg_transform_parameter,
	);
}

with qw(
	Intertangle::Taffeta::Graphics::Image::Role::FromCairoImageSurface
	Intertangle::Taffeta::Graphics::Role::SVGRenderable
	Intertangle::Taffeta::Graphics::Role::WithBounds
	Intertangle::Taffeta::Graphics::Role::WithTransform
	Intertangle::Taffeta::Graphics::Role::SVGRenderable::Transform
);

1;
