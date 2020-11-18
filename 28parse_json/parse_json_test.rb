require_relative "../lib/io_test_helpers"
require "minitest/autorun"
require_relative "parse_json"

class ParseJsonTest < Minitest::Test
  include MoviesJsonParser

  def test_parse_movies
    # skip
    json = '[
      {
          "title": "Some Title",
          "genre": [
              "genre 1",
              "genre 2"
          ],
          "gross": 23.6
      }
    ]'
    File.open("test.json", "w") { |file| file.write(json) }

    test = parse_movies("test.json")

    assert_equal  ({ "title" => "Some Title", "genre" => ["genre 1", "genre 2"], "gross" => 23.6 }),
                  test[0]
  end

  def test_export_movies_to_json
    # skip
    movies = [
      { "title" => "New Title", "genre" => ["genre 3", "genre 4"], "gross" => 23.6 },
      { "title" => "Other Title", "genre" => ["genre 1"], "gross" => 9.6 }
    ]

    export_json(movies, "test.json")

    json = JSON.parse(File.read("test.json"))

    assert_equal  "New Title", json[0]["title"]
    assert_equal  "Other Title", json[1]["title"]
    assert_equal  ["genre 3", "genre 4"], json[0]["genre"]
    assert_equal  ["genre 1"], json[1]["genre"]
    assert_equal  23.6, json[0]["gross"]
    assert_equal  9.6, json[1]["gross"]
  end
end