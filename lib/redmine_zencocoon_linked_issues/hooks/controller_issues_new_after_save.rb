module RedmineZenCocoonLinkedIssues
  module Hooks
    class ControllerIssuesNewAfterSave < Redmine::Hook::ViewListener
      def controller_issues_new_after_save(context={})
        if context[:params] && context[:params][:issue_from_id]
          issue_to = context[:issue]
          issue_from = Issue.find(context[:params][:issue_from_id])

          if User.current.allowed_to?(:manage_issue_relations, issue_from.project)
            IssueRelation.create!(:issue_from => issue_from, :issue_to => issue_to, :relation_type => 'relates')
            if context[:params][:continue]
              raise RedmineZenCocoonLinkedIssues::RedirectToNewIssueFrom, "#{issue_to.project.identifier}-#{issue_from.id}"
            else
              raise RedmineZenCocoonLinkedIssues::RedirectToIssuesNb, issue_from.id.to_s
            end
          end
        end

        return ''
      end
    end
  end
end
