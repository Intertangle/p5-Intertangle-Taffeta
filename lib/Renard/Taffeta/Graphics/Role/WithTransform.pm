use Renard::Incunabula::Common::Setup;
package Renard::Taffeta::Graphics::Role::WithTransform;
# ABSTRACT: A role that holds a transform

use Mu::Role;
use Renard::Taffeta::Transform::Affine2D;

=attr transform

The transform to apply.

=cut
has transform => (
	is => 'ro',
	default => sub {
		Renard::Taffeta::Transform::Affine2D->new,
	},
);

lazy transformed_bounds => method () {
	$self->transform->apply_to_bounds( $self->identity_bounds );
};

1;
