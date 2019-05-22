require 'spec_helper'
require_relative '../app/slack'

RSpec.describe App::Slack do
    it "posts new message to github-slack-int channel" do
        client = double(:client)
        ENV["SLACK_CHANNEL"] = "xyz"

        allow(::Slack::Web::Client).to receive(:new) { client }

        allow(client).to receive(:auth_test) { true }
        allow(client).to receive(:chat_postMessage).with({ :as_user => true,
        :text=>"Author : snehaso pushed 2 commits to refs/heads/master.", :channel => 'xyz'})

        App::Slack.notify_push_event('refs/heads/master', 'snehaso', '2', {'head_commit' => 123, 'before_commit' => '567'})
    end
end