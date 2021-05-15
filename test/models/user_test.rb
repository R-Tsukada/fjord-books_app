# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#name_or_email' do
    user = User.new(email: 'foo@example.com', name: '')
    assert_equal 'foo@example.com', user.name_or_email

    user.name = 'foo bar'
    assert_equal 'foo bar', user.name_or_email
  end

  test '#following?' do
    alice = users(:alice)
    bob = users(:bob)

    alice.follow(bob)
    assert alice.following?(bob)
    assert bob.followed_by?(alice)
  end

  test '#follow' do
    carol = users(:carol)
    dave = users(:dave)

    assert_not carol.following?(dave)
    carol.following?(dave)
    carol.follow(dave)
    assert carol.following?(dave)
  end

  test '#unfollow' do
    ellen = users(:ellen)
    frank = users(:frank)

    ellen.follow(frank)
    assert ellen.following?(frank)
    ellen.unfollow(frank)
    assert_not frank.followed_by?(ellen)
  end
end
