use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Style::Fill;
# ABSTRACT: Fill style

use Moo;
use Renard::Taffeta::Types qw(Color Opacity Dimension);

has opacity => (
	is => 'ro',
	predicate => 1,
	default => sub { 1 },
	isa => Opacity,
);

has color => (
	is => 'ro',
	predicate => 1,
	isa => Color,
);

method is_fill_none() {
	return ! $self->has_color && ! $self->has_opacity;
}

method svg_style() {
	my $data = {};

	if( $self->is_fill_none ) {
		$data->{fill} = 'none';
	} elsif( $self->has_color ) {
		$data->{fill} = $self->color->svg_value;
	}

	if( $self->has_opacity ) {
		$data->{'fill-opacity'} = $self->opacity;
	}

	$data;
}

1;
