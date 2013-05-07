# require 'redmine'

# Including dispatcher.rb in case of Rails 2.x
require 'dispatcher' unless Rails::VERSION::MAJOR >= 3

if Rails::VERSION::MAJOR >= 3
  ActionDispatch::Callbacks.to_prepare do
    require_dependency 'issues_controller'
    unless IssuesController.included_modules.include?(RedmineZenCocoonLinkedIssues::Patchs::IssuesControllerPatch)
      IssuesController.send(:include, RedmineZenCocoonLinkedIssues::Patchs::IssuesControllerPatch)
    end
  end
else
  Dispatcher.to_prepare :redmine_zencocoon_linked_issues do
    require_dependency 'issues_controller'
    unless IssuesController.included_modules.include?(RedmineZenCocoonLinkedIssues::Patchs::IssuesControllerPatch)
      IssuesController.send(:include, RedmineZenCocoonLinkedIssues::Patchs::IssuesControllerPatch)
    end
  end
end

Redmine::Plugin.register :redmine_zencocoon_linked_issues do
  name 'Redmine Zencocoon Linked Issues Plugin'
  author 'Sebastien Grosjean - ZenCocoon'
  description 'Create linked issues owned by a predefined project with extreme ease.'
  version '1.1.0'
  author_url 'http://www.zencocoon.com'
end

require 'redmine_zencocoon_linked_issues/constants'
require 'redmine_zencocoon_linked_issues/errors'
require 'redmine_zencocoon_linked_issues/patchs/issues_controller_patch'
require 'redmine_zencocoon_linked_issues/hooks/view_issues_form_details_top'
require 'redmine_zencocoon_linked_issues/hooks/controller_issues_new_after_save'