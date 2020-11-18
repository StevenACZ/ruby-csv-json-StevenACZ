require_relative "../lib/io_test_helpers"
require "minitest/autorun"
require_relative "parse_csv"

class ParseCsvTest < Minitest::Test
  include MoviesCsvParser

  def test_parse_csv_movies
    skip
    File.open("test.csv", "w") { |file| file.write("title,genre,gross\nSome Title,\"genre 1, genre 2\",$23.60M\n")}

    test = parse_csv_movies("test.csv")

    assert_equal  ({ "title" => "Some Title", "genre" => ["genre 1", "genre 2"], "gross" => 23.6 }),
                  test[0]
  end

  def test_export_movies_to_csv
    # skip
    movies = [
      { "title" => "New Title", "genre" => ["genre 3", "genre 4"], "gross" => 23.6 },
      { "title" => "Other Title", "genre" => ["genre 1"], "gross" => 9.6 }
    ]

    export_csv(movies, "test.csv")

    csv = CSV.parse(File.read("test.csv"), headers: true)

    assert_equal  "New Title", csv[0]["title"]
    assert_equal  "Other Title", csv[1]["title"]
    assert_equal  "genre 3, genre 4", csv[0]["genre"]
    assert_equal  "genre 1", csv[1]["genre"]
    assert_equal  "$23.60M", csv[0]["gross"]
    assert_equal  "$9.60M", csv[1]["gross"]
  end
end