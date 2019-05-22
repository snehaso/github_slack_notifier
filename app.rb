require 'sinatra'
require_relative 'app/slack'
require 'pry'

post '/notify_slack' do
    extra_info = { :head_commit => params['head'], :before_commit => params['before'] }

    Slack.notify_push_event(params['ref'],params['commit_author'], params['size'], {'head_commit': params['head'], 'before_commit': params['before']})
    return :ok
end