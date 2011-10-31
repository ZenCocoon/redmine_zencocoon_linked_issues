module RedmineZenCocoonLinkedIssues
  module Patchs
    module IssuesControllerPatch
      def self.included(base) # :nodoc:
        base.class_eval do
          rescue_from RedmineZenCocoonLinkedIssues::RedirectToIssuesNb, :with => :redirect_to_issue_nb
          rescue_from RedmineZenCocoonLinkedIssues::RedirectToNewIssueFrom, :with => :redirect_to_new_issue_from

          def redirect_to_issue_nb(exception)
            redirect_to({ :action => 'show', :controller => 'issues', :id => exception.message})
          end

          def redirect_to_new_issue_from(exception)
            project_id, issue_from_id = exception.message.split('-')
            redirect_to({ :action => 'new', :controller => 'issues',
                          :project_id => project_id, :issue_from_id => issue_from_id})
          end
        end
      end
    end
  end
end
