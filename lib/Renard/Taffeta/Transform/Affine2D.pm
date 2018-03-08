use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Transform::Affine2D;
# ABSTRACT: A 2D affine transform

use Mu;
use Renard::Incunabula::Common::Types qw(InstanceOf Str Bool);
use Renard::Yarn::Graphene;
use List::AllUtils qw(all);

=method compose

Compose the transform with another transform by using matrix multiplication.

=cut
method compose( $transform ) {
	Renard::Taffeta::Transform::Affine2D->new(
		matrix => ( $self->matrix x $transform->matrix ),
	);
}

=method apply_to_bounds

Apply the transformation to a C<Renard::Yarn::Graphene::Rect>.

=cut
method apply_to_bounds( $bounds ) {
	$self->matrix->transform_bounds( $bounds );
}

=attr matrix

The C<Renard::Yarn::Graphene::Matrix> matrix representing the affine transform.

This matrix is the identity matrix by default.

=cut
has matrix => (
	is => 'ro',
	isa => InstanceOf['Renard::Yarn::Graphene::Matrix'],
	default => sub {
		my $m = Renard::Yarn::Graphene::Matrix->new;
		$m->init_identity;
		$m;
	},
);

=method BUILDARGS


matrix_abcdef

   [
       a c 0 0
       b d 0 0
       0 0 1 0
       e f 0 1
   ]

matrix_xy

  [
     xx yx  0  0
     xy yy  0  0
      0  0  1  0
     x0 y0  0  1
  ]

If keys are not given for either approach, the default values for the identity
matrix are used:

  a, d : 1
  b, c : 0
  e, f : 0

  xx, yy : 1
  yx, xy : 0
  x0, y0 : 0

=cut
around BUILDARGS => fun( $orig, $class, %args ) {
	my $matrix;

	if( keys %args > 1 ) {
		die "Can not use multiple approaches to construct matrix";
	} elsif( keys %args == 1 ) {
		if( exists $args{matrix} ) {
			my $ma = $args{matrix}->to_ArrayRef;
			# NOTE this uses exact checking instead of floating point
			# approximation. This should be fine because these are values
			# that are set by the user.
			unless(
				(
					all { $_ == 0 } (
						$ma->[0][2], $ma->[0][3],
						$ma->[1][2], $ma->[1][3],
						$ma->[2][0], $ma->[2][1],
						$ma->[3][2], $ma->[2][3],
					)
				)
				&&
				(
					all { $_ == 1 } (
						$ma->[2][2], $ma->[3][3],
					)
				)
			) {
				die "Not a 2D affine transform matrix";
			}
			$matrix = $args{matrix};
		} elsif( exists $args{matrix_abcdef} ) {
			$matrix = Renard::Yarn::Graphene::Matrix->new;
			$matrix->init_from_2d(
				$args{matrix_abcdef}{a} // 1, $args{matrix_abcdef}{c} // 0,
				$args{matrix_abcdef}{b} // 0, $args{matrix_abcdef}{d} // 1,

				$args{matrix_abcdef}{e} // 0 , $args{matrix_abcdef}{f} // 0,
			);
		} elsif( exists $args{matrix_xy} ) {
			$matrix = Renard::Yarn::Graphene::Matrix->new;
			$matrix->init_from_2d(
				$args{matrix_xy}{xx} // 1,
				$args{matrix_xy}{yx} // 0,
				$args{matrix_xy}{xy} // 0,
				$args{matrix_xy}{yy} // 1,
				$args{matrix_xy}{x0} // 0,
				$args{matrix_xy}{y0} // 0,
			);
		} else {
			die "Unknown args: @{[ %args ]}";
		}

		$args{matrix} = $matrix;
	}


	return $class->$orig(%args);
};

=attr cairo_matrix

A C<Cairo::Matrix> representation of the affine transform.

=cut
lazy cairo_matrix => method() {
	require Cairo;

	my (
		$is_2d_affine,
		$xx, $yx,
		$xy, $yy,
		$x0, $y0
	) = $self->matrix->to_2d;

	die "Not a 2D affine matrix" unless $is_2d_affine;

	my $cairo_matrix = Cairo::Matrix->init(
		$xx, $yx,
		$xy, $yy,
		$x0, $y0
	);

	$cairo_matrix;
}, isa => InstanceOf['Cairo::Matrix'];

=attr svg_transform

A C<Str> representation of the affine transform that can be used with
C<transform> attribute for SVG elements such as C<< <g> >> or graphics
elements.

See L<https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/transform>.

=cut
lazy svg_transform => method() {
	# / a c e \
	# | b d f |
	# \ 0 0 1 /
	my (
		$is_2d_affine,
		$xx, $yx,  # a c
		$xy, $yy,  # b d

		$x0,  # e
		$y0   # f
	) = $self->matrix->to_2d;

	die "Not a 2D affine matrix" unless $is_2d_affine;

	my (
	$m_a , $m_c,
	$m_b , $m_d,

	$m_e,
	$m_f
	) = (
		$xx, $yx,
		$xy, $yy,

		$x0,
		$y0
	);

	return sprintf("matrix(%f, %f, %f, %f, %f, %f)",
		$m_a, $m_b,
		$m_c, $m_d,
		$m_e, $m_f,
	);
}, isa => Str;

lazy is_identity => method() {
	$self->matrix->is_identity;
}, isa => Bool;


1;
