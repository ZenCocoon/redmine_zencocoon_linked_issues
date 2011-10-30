require 'redmine'

Redmine::Plugin.register :redmine_zencocoon_linked_issues do
  name 'Redmine Zencocoon Linked Issues Plugin'
  author 'Sébastien Grosjean - ZenCocoon'
  description 'Create linked issues owned by a predefined project with extreme ease.'
  version '0.0.1'
  author_url 'http://www.zencocoon.com'
end

require 'redmine_zencocoon_linked_issues/constants'
require 'redmine_zencocoon_linked_issues/errors'
require 'redmine_zencocoon_linked_issues/patchs/issues_controller_patch'
require 'redmine_zencocoon_linked_issues/hooks/view_issues_form_details_top'
require 'redmine_zencocoon_linked_issues/hooks/controller_issues_new_after_save'