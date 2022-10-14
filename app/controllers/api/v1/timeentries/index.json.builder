json.array! @timeentries do |timeentry|
  json.extract! timeentry, :id, :start_date
end
