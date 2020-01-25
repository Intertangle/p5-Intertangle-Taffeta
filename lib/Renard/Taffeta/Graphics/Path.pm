use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Graphics::Path;
# ABSTRACT: 

use Moo;

extends qw(Renard::Taffeta::Graphics);

use MooX::HandlesVia;
use Renard::Taffeta::Types qw(CairoContext);

has _segments => (
	is => 'ro',
	default => sub { [] },
	handles_via => 'Array',
	handles => {
		_add_segment => 'push',
	},
);

method move_to( $point ) {
	$self->_add_segment( [ 'move', $point ] );
}

method line_to( $point ) {
	$self->_add_segment( [ 'line', $point ] );
}

method close_path() {
	$self->_add_segment( [ 'close' ] );
}

=method render_cairo

See L<Renard::Taffeta::Graphics::Role::CairoRenderable>.

=cut
method render_cairo( (CairoContext) $cr ) {
	my $create_path = sub {
		$cr->new_path;
		for my $seg (@{ $self->_segments }) {
			if( $seg->[0] eq 'move' ) {
				$cr->move_to( $seg->[1]->x, $seg->[1]->y );
			} elsif( $seg->[0] eq 'line' ) {
				$cr->line_to( $seg->[1]->x, $seg->[1]->y );
			} elsif( $seg->[0] eq 'close' ) {
				$cr->close_path;
			} else {
				die "unknonwn command: @{[ $seg->[0] ]}";
			}
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

with qw(
	Renard::Taffeta::Graphics::Role::WithFill
	Renard::Taffeta::Graphics::Role::WithStroke
	Renard::Taffeta::Graphics::Role::CairoRenderable
);

1;
