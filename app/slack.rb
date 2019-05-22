require 'pry'
require 'slack-ruby-client'
module App
    class Slack
        def self.notify_push_event(ref, commit_author, size, extra_info)
            client = ::Slack::Web::Client.new
            client.auth_test
            client.chat_postMessage(channel: ENV['SLACK_CHANNEL'],
                                    text: "Author : #{commit_author} pushed #{size} commits to #{ref}.",
                                    as_user: true)
        end
    end
end