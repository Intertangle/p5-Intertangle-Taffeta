use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Transform::Affine2D::WithOrigin;
# ABSTRACT: An affine 2D transformation about an origin

use Mu;

extends qw(Renard::Taffeta::Transform::Affine2D);

use Renard::Yarn::Types qw(Point);
use Renard::Taffeta::Transform::Affine2D::Translation;

=attr affine2d

The affine 2D transform to use with origin [0,0].

=cut
has affine2d => (
	is => 'ro',
	required => 1,

);

=attr origin

A C<Point> that is the origin of the transform.

=cut
has origin => (
	is => 'ro',
	isa => Point,
	coerce => 1,
);

lazy matrix => method() {
	my $back = Renard::Taffeta::Transform::Affine2D::Translation->new(
		translate => - $self->origin,
	);
	my $forward = Renard::Taffeta::Transform::Affine2D::Translation->new(
		translate => $self->origin,
	);

	$back->matrix x $self->affine2d->matrix x $forward->matrix;
};

1;
