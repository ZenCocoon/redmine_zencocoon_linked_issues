# Redmine ZenCocoon Linked Issues

This plugin allows you to create linked issues owned by a predefined project with extreme ease.

## Workflow:

Having predefined the `Project A` using the install process bellow
When I see the `Issue A` from the `Project B`
I can create a linked issue attached to the `Project A` using a link
Once created, both issues will be linked
I'll return to the `Issue A`

## Install

Copy the plugin source as `vendor/plugins/redmine_zencocoon_linked_issues`

## Setup

Allow cross-project issue relations from `/settings?tab=issues`
Setup the project ID (eg. 1) within `lib/redmine_zencocoon_linked_issues/constants.rb`
Update the link name if needed with the translations files at `config/locales/*.yml` and `lang/*.yml`

## Usage

To use in a `development` environment, please make sure to add the following settings in you `config/environments/development.rb`

    config.to_prepare do
      IssuesController.send(:include, RedmineZenCocoonLinkedIssues::IssuesControllerPatch)
    end

## License

MIT License. Copyright 2011 Sébastien Grosjean