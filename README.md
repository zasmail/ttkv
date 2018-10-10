# TTKV

*Paraphrasing here...*

Write a class with two methods: put and get

## PUT
Given a key and value, store the pair with a timestamp associated with this action

## Get
Given a key and timestamp, retrieve the value associated with the value at that time. If timestamp is nil, retrieve last value.

##Get with time interval
Given a key and times interval, retrieve the value time object associated with that time interval. If start time is nil, assume start unix timestamp 0. If end time is nil, assume current time. 

## [All tests passing](https://github.com/zasmail/ttkv/blob/master/ttkv_test.rb)
![alt text](https://i.imgur.com/1OcnJub.png)
