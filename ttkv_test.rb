require_relative "ttkv"
require "test/unit"

class TTKVTEST < Test::Unit::TestCase

  def test_push_single_object
    timestore = TTKV::new
    keystore = timestore.put("a", "b")
    assert_equal(keystore.first[:value], "b")
  end

  def test_get_single_object
    timestore = TTKV::new
    timestore.put("a", "b")
    assert_true(!timestore.get("a").nil?)
    assert_true(timestore.get("not in set").nil?)
  end

  def test_similar_keys
    test_key = "test key"
    timestore = TTKV::new
    [*0..10].each do |index|
      sleep 0.3
      timestore.put(test_key, index)
    end
    timestamps = timestore.get_all_vals_for_key(test_key).map{|value_time| value_time[:timestamp]}
    assert_equal(timestore.get(test_key, timestamps.first)[:value], 0)
    assert_equal(timestore.get(test_key, timestamps.last)[:value], 10)
    sleep 0.5
    assert_equal(timestore.get(test_key, Time.now), nil)
    assert_equal(timestore.get(test_key, nil)[:value], 10)
  end

  def test_time_intervals
    test_key = "test key"
    timestore = TTKV::new
    [*0..10].each do |index|
      sleep 0.3
      timestore.put(test_key, index)
    end
    timestamps = timestore.get_all_vals_for_key(test_key).map{|value_time| value_time[:timestamp]}

    assert_equal(timestore.get_time_interval(test_key).count, 11)
    assert_equal(timestore.get_time_interval(test_key, timestamps.first, timestamps.last).count, 11)
    assert_equal(timestore.get_time_interval(test_key, timestamps.first, timestamps.last).count, 11)
    assert_true(!timestore.get_time_interval(test_key, timestamps[-3], timestamps.last).find{|value_time| value_time[:value] == 9}.nil?)

  end



end
