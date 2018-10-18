#!/usr/bin/env perl

use Test::Most;

use lib 't/lib';
use Renard::Incunabula::Devel::TestHelper;

use Renard::Incunabula::Common::Setup;
use Renard::Taffeta::Graphics::Image::PNG;
use Renard::Yarn::Graphene;

my $png_path = try {
	Renard::Incunabula::Devel::TestHelper->test_data_directory->child(qw(PNG libpng ccwn3p08.png));
} catch {
	plan skip_all => "$_";
};

plan tests => 3;

my ($x, $y) = (30, 30);
my $gfx_png = Renard::Taffeta::Graphics::Image::PNG->new(
	data => $png_path->slurp_raw,
	origin => Renard::Yarn::Graphene::Point->new( x => $x, y => $y ),
);

subtest "Attributes" => sub {
	is $gfx_png->origin->x, $x, 'correct x position';
	is $gfx_png->origin->y, $y, 'correct y position';
	is $gfx_png->size->width, 32, 'correct width';
	is $gfx_png->size->height, 32, 'correct height';
};

subtest "Render to Cairo" => sub {
	require Cairo;
	my $surface = Cairo::ImageSurface->create('argb32', 100, 100);
	my $cr = Cairo::Context->create( $surface );

	$gfx_png->render_cairo( $cr );

	my $png_surface = $gfx_png->cairo_image_surface;
	my ($format, $width, $height) = (
		$png_surface->get_format,
		$png_surface->get_width,
		$png_surface->get_height
	);

	# crop the original PNG out of the surface we rendered to
	my $crop_surface = Cairo::ImageSurface->create($format, $width, $height);
	my $crop_cr = Cairo::Context->create( $crop_surface );
	$crop_cr->set_source_surface( $surface,
		-( $gfx_png->origin->x ), -( $gfx_png->origin->y ) );
	$crop_cr->paint;

	is $png_surface->get_data, $crop_surface->get_data,
		'the data from the original PNG is in the correct position';
};

subtest "Render to SVG" => sub {
	require SVG;
	SVG->import;
	my $svg = SVG->new( width => 100, height => 100 );

	$gfx_png->render_svg( $svg );

	like $svg->xmlify, qr|data:image/png;base64,iVBORw0KGgo|, 'XML has Base64 encoded PNG';
};

done_testing;
