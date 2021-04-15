# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#created_on' do
    report = reports(:alice_report)
    assert_equal report.created_at.to_date, report.created_on
  end

  test '#editable' do
    bob = users(:bob)
    bob_report = reports(:bob_report)
    assert bob_report.editable?(bob)

    carol = users(:carol)
    assert_not bob_report.editable?(carol)
  end
end
