require 'spec_helper'
require 'digest'
require_relative '../app/slack'

RSpec.describe "app", type: :controller do
    context "post github push notification to slack" do
        it "sends notification to slack with required commit data" do
            commit_author = "snehaso"
            ref = 'refs/heads/master'
            size = '2'
            extra_info = { :head_commit => Digest::SHA1.hexdigest('random') , :before_commit => Digest::SHA1.hexdigest('random2')}

            expect(Slack).to receive(:notify_push_event).with(ref,commit_author, size, extra_info)
            post '/notify_slack', {'commit_author' => commit_author, 'ref' => ref, 'size' => size, 'head' => extra_info[:head_commit], 'before' => extra_info[:before_commit] }

            expect(last_response.status).to eq(200)
        end
    end
end