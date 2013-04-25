#!/usr/bin/env ruby
# vim: set ts=2 sw=2 ai et ruler:

require 'yaml'
require 'csv'  # ruby 1.9.3
require 'puppet'

data_dir = '/tmp/inventory'
outfile  = '/tmp/inventory.csv'

# find unique set of all headers
headers = Array.new
Dir.glob(File.join(data_dir, '*.yaml')).each do |path|
  h = YAML.load_file(path).values rescue nil
  if h
    # some keys are ruby symbols, but we need strings
    h.each_key {|k| headers << k.to_s}
  end
end
headers.sort!
headers.uniq!
headers.compact!
headers

# create a hash where each header becomes a key and each value is nil
# (kind of like an empty egg)
eggs = Hash.new
headers.each {|k| eggs[k] = nil}

# read the files again, consuming the entire hash from yaml
rows = Array.new
Dir.glob(File.join(data_dir, '*.yaml')).each do |path|
  hash = YAML.load_file(path).values rescue nil
  if hash
    # replace every newline with a space
    hash.each do |k,v|
      hash[k] = v.to_s.gsub(/\n/, ' ')
    end

    # breakfast isn't complete without eggs and hash
    eggs_and_hash = eggs.merge(hash)

    row = CSV::Row.new([], [], true) # empty row
    row << eggs_and_hash
    rows << row
  end
end

# sort the records by fqdn
rows.sort! {|a, b| a['fqdn'] <=> b['fqdn']}

# create table and write to file
File.open(outfile, 'wb') do |file|
  file.puts rows.first.headers.to_csv
  rows.each {|row| file.puts row.to_csv}
end
