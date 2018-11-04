#!/usr/bin/env perl

use Test::Most tests => 3;
use Renard::Incunabula::Common::Setup;
use Renard::Taffeta::Graphics::Rectangle;

use Renard::Taffeta::Transform::Affine2D;
use Renard::Taffeta::Transform::Affine2D::Scaling;
use Renard::Taffeta::Transform::Affine2D::Translation;

subtest "Identity" => sub {
	my $rect = Renard::Taffeta::Graphics::Rectangle->new(
		transform => Renard::Taffeta::Transform::Affine2D->new,
		width => 10,
		height => 20,
	);

	my $tb = $rect->transformed_bounds;
	is $tb->origin, [0, 0], 'transform origin still at (0,0)';
	is $tb->size, [10, 20], 'transform size is identity size';
};

subtest "Scale x,y" => sub {
	my $rect = Renard::Taffeta::Graphics::Rectangle->new(
		transform => Renard::Taffeta::Transform::Affine2D::Scaling->new(
			scale => [ 2, 3 ],
		),
		width => 10,
		height => 20,
	);

	my $tb = $rect->transformed_bounds;
	is $tb->origin, [0, 0], 'transform origin still at (0,0)';
	is $tb->size, [20, 60], 'transform size is scaled';
};

subtest "Translate x,y" => sub {
	my $rect = Renard::Taffeta::Graphics::Rectangle->new(
		transform => Renard::Taffeta::Transform::Affine2D::Translation->new(
			translate => [ 100, 200, ],
		),
		width => 10,
		height => 20,
	);

	my $tb = $rect->transformed_bounds;
	is $tb->origin, [100, 200], 'transform origin translated to (100,200)';
	is $tb->size, [10, 20], 'transform size is identity size';
};

done_testing;
