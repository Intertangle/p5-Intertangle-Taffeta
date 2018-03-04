use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Graphics::Image::PNG;
# ABSTRACT: Raster data stored in PNG format

use Moo;
use Renard::Incunabula::Common::Types qw(Str InstanceOf Int);
use Renard::Taffeta::Types qw(SVG);
use MIME::Base64;
use Image::Size;

extends qw(Renard::Taffeta::Graphics::Image);

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

method _build_size() :ReturnType(InstanceOf['Renard::Yarn::Graphene::Size']) {
	my ($width, $height, $id_or_error) = Image::Size::imgsize( \($self->data) );
	die "Could not compute bounds: $id_or_error" unless $id_or_error eq 'PNG';
	Renard::Yarn::Graphene::Size->new(
		width => $width,
		height => $height,
	);
}

=method render_svg

See L<Renard::Taffeta::Graphics::Role::SVGRenderable>.

=cut
method render_svg( (SVG) $svg ) {
	$svg->image(
		x => $self->position->x,
		y => $self->position->y,
		'-href' => "data:image/png;base64,@{[ encode_base64( $self->data ) ]}",
	);
}

with qw(
	Renard::Taffeta::Graphics::Image::Role::FromCairoImageSurface
	Renard::Taffeta::Graphics::Role::SVGRenderable
);

1;
