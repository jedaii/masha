class MembershipAuthorizer < ApplicationAuthorizer

	def creatable_by?(user)
		has_permission?(user)
	end

	def updatable_by?(user)
		has_permission?(user)
	end

	def deletable_by?(user)
		has_permission?(user)
	end

	protected

	def has_permission?(user)
		user.is_root? || user.has_role?(:owner, resource.project)
	end

end