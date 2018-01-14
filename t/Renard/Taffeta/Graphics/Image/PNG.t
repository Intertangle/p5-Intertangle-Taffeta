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

plan tests => 2;

my $gfx_png = Renard::Taffeta::Graphics::Image::PNG->new(
	data => $png_path->slurp_raw,
	position => Renard::Yarn::Graphene::Point->new( x => 30, y => 30 ),
);

subtest "Render to Cairo" => sub {
	require Cairo;
	my $surface = Cairo::ImageSurface->create ('argb32', 100, 100);
	my $cr = Cairo::Context->create ($surface);

	$gfx_png->render_cairo( $cr );

	$surface->write_to_png('output.png');

	ok -f 'output.png', 'file exists TODO';
};

subtest "Render to SVG" => sub {
	require SVG;
	SVG->import;
	my $svg = SVG->new( width => 100, height => 100 );

	$gfx_png->render_svg( $svg );

	like $svg->xmlify, qr|data:image/png;base64,iVBOR|, 'XML has Base64 encoded PNG';
};

done_testing;
