require 'application_system_test_case'

class OAuthTest < ApplicationSystemTestCase
  setup do
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:github, { uid: '12345', info: { name: 'alice', email: 'alice@example.com' } })
  end

  test 'GitHub sign up' do
    visit root_path
    click_link 'GitHubでログイン'
    click_link 'ユーザ'
    within 'table' do
      assert_text 'alice@example.com'
    end
  end
end