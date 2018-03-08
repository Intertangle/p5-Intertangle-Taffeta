#!/usr/bin/env perl

use Test::Most tests => 3;
use Renard::Incunabula::Common::Setup;
use Renard::Taffeta::Transform::Affine2D;
use Renard::Taffeta::Graphics::Rectangle;

subtest "Identity" => sub {
	my $transform = Renard::Taffeta::Transform::Affine2D->new;

	my $rect = Renard::Taffeta::Graphics::Rectangle->new(
		transform => $transform,
		width => 10,
		height => 20,
	);

	my $tb = $rect->transformed_bounds;
	is $tb->origin, [0, 0], 'transform origin still at (0,0)';
	is $tb->size, [10, 20], 'transform size is identity size';
};

subtest "Scale x,y" => sub {
	my $transform = Renard::Taffeta::Transform::Affine2D->new(
		matrix_abcdef => { a => 2, d => 3, },
	);

	my $rect = Renard::Taffeta::Graphics::Rectangle->new(
		transform => $transform,
		width => 10,
		height => 20,
	);

	my $tb = $rect->transformed_bounds;
	is $tb->origin, [0, 0], 'transform origin still at (0,0)';
	is $tb->size, [20, 60], 'transform size is scaled';
};

subtest "Translate x,y" => sub {
	my $transform = Renard::Taffeta::Transform::Affine2D->new(
		matrix_abcdef => { e => 100, f => 200, },
	);

	my $rect = Renard::Taffeta::Graphics::Rectangle->new(
		transform => $transform,
		width => 10,
		height => 20,
	);

	my $tb = $rect->transformed_bounds;
	is $tb->origin, [100, 200], 'transform origin translated to (100,200)';
	is $tb->size, [10, 20], 'transform size is identity size';
};

done_testing;
