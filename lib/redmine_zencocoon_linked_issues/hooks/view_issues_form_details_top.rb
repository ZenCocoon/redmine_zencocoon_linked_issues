module RedmineZenCocoonLinkedIssues
  module Hooks
    class ViewIssuesFormDetailsTop < Redmine::Hook::ViewListener
      render_on :view_issues_form_details_top,
                :partial => 'issues/hooks/view_issues_form_details_top'
    end
  end
end