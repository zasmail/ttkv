class TTKV
  def initialize
    # keystore, formatted like {"key":[value: "value", timestamp: 2018-10-10 14:02:09 -0700]}
    @keystore = {}
  end
  def put(key, value)
    # place key value pair in @keystore
    # if no key previously, create a new array
    # if key exsists, inject new value time object
    @keystore[key] = @keystore[key].nil? ? [{timestamp: Time.new(), value: value}] : @keystore[key] << {timestamp: Time.new(), value: value }
  end

  def get(key, timestamp=nil)
    # retreive key given a timestamp, if no timestamp, return last value time object
    # if no match on key, return nil
    if !@keystore[key].nil?
      if timestamp.nil?
        return @keystore[key].last
      end
      @keystore[key].find{|value_time| value_time[:timestamp] == timestamp }
    end
  end

  def get_time_interval(key, timestamp_start=nil, timestamp_end=nil)
    # given a key, return an array of value time objects given a time range
    if timestamp_start.nil?
      # if start time not defined, use first timestamp
      timestamp_start = Time.new(0)
    end
    if timestamp_end.nil?
      # if start time not defined, use current time
      timestamp_end = Time.new
    end

    # if no match on key, return nil
    if !@keystore[key].nil?
      @keystore[key].select{|value_time| value_time[:timestamp] >= timestamp_start &&  value_time[:timestamp] <= timestamp_end }
    end
  end

  def get_all_vals_for_key(key)
    # for testing purposes retrieve all vals for given key
    @keystore[key]
  end
end
