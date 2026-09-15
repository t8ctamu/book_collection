titles = case Rails.env
when "production", "review"
  [ "Pride and Prejudice", "Jane Eyre", "The Great Gatsby", "Moby-Dick", "Little Women" ]
when "test"
  [ "Test Book One", "Test Book Two", "Test Book Three", "Test Book Four", "Test Book Five" ]
else
  [ "The Hobbit", "Dune", "Fahrenheit 451", "The Odyssey", "The Secret Garden" ]
end

titles.each do |title|
  Book.find_or_create_by!(title: title)
end

puts "Seeded #{titles.size} books in #{Rails.env} (#{Book.count} total)."
