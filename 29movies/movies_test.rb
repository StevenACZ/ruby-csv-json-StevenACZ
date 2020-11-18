require_relative "../lib/io_test_helpers"
require "minitest/autorun"
require_relative "movies"
require "json"

class MoviesTest < Minitest::Test
  def test_initialize_movies
    # skip
    File.open("store.json", "w") { |json| json.write("[]") }
    movies = Movies.new("store.json")

    assert_instance_of Movies, movies
  end

  def test_create_new_movie
    # skip
    File.open("store.json", "w") { |json| json.write("[]") }
    movies = Movies.new("store.json")
    new_movie = { "title" => "New Title", "genre" => ["genre 3", "genre 4"], "gross" => 23.6 }
    movies.create(new_movie)

    movies_on_file = JSON.parse(File.read("store.json"))
    assert_equal new_movie["title"], movies_on_file[0]["title"]
    assert_equal new_movie["genre"], movies_on_file[0]["genre"]
    assert_equal new_movie["gross"], movies_on_file[0]["gross"]
    assert_equal 1, movies_on_file[0]["id"], "Add new ID when create a movie"
  end

  def test_find_movie
    # skip
    data = '[
      {
          "title": "Some Title",
          "genre": [
              "genre 1",
              "genre 2"
          ],
          "gross": 23.6,
          "id": 1
      }
  ]'
    File.open("store.json", "w") { |json| json.write(data) }
    movies = Movies.new("store.json")
    movie = movies.find(1)

    assert_equal movie["title"], "Some Title"
    assert_equal movie["genre"], ["genre 1", "genre 2"]
    assert_equal movie["gross"], 23.6
    assert_equal movie["id"], 1
  end

  def test_return_all_movies
    # skip
    data = '[
      {
          "title": "Some Title",
          "genre": [
              "genre 1",
              "genre 2"
          ],
          "gross": 23.6,
          "id": 1
      },
      {
          "title": "Other Title",
          "genre": [
              "genre 3",
              "genre 4"
          ],
          "gross": 10.00,
          "id": 2
      }
  ]'
    File.open("store.json", "w") { |json| json.write(data) }
    movies = Movies.new("store.json")
    all_movies = movies.all

    assert_equal 2, all_movies.size
    assert_equal "Some Title", all_movies[0]["title"]
    assert_equal "Other Title", all_movies[1]["title"]
  end

  def test_update_movie
    # skip
    data = '[
      {
          "title": "Some Title",
          "genre": [
              "genre 1",
              "genre 2"
          ],
          "gross": 23.6,
          "id": 1
      },
      {
          "title": "Other Title",
          "genre": [
              "genre 3",
              "genre 4"
          ],
          "gross": 10.00,
          "id": 2
      }
  ]'
    File.open("store.json", "w") { |json| json.write(data) }
    movies = Movies.new("store.json")
    updated = movies.update(2, {"gross" => 30})

    assert_equal 30, movies.find(2)["gross"]
  end

  def test_delete_movie
    # skip
    data = '[
      {
          "title": "Some Title",
          "genre": [
              "genre 1",
              "genre 2"
          ],
          "gross": 23.6,
          "id": 1
      },
      {
          "title": "Other Title",
          "genre": [
              "genre 3",
              "genre 4"
          ],
          "gross": 10.00,
          "id": 2
      }
  ]'
    File.open("store.json", "w") { |json| json.write(data) }
    movies = Movies.new("store.json")
    movies.delete(2)

    assert movies.find(1)
    assert_nil movies.find(2)
  end

  def test_delete_all_movies
    # skip
    data = '[
      {
          "title": "Some Title",
          "genre": [
              "genre 1",
              "genre 2"
          ],
          "gross": 23.6,
          "id": 1
      },
      {
          "title": "Other Title",
          "genre": [
              "genre 3",
              "genre 4"
          ],
          "gross": 10.00,
          "id": 2
      }
  ]'
    File.open("store.json", "w") { |json| json.write(data) }
    movies = Movies.new("store.json")
    movies.delete_all

    assert_equal [], movies.all
  end

  def test_import_csv
    # skip
    data = "title,genre,gross\nSome Title,\"genre 1, genre 2\",$23.60M\n"
    File.open("data.csv", "w") { |csv| csv.write(data) }
    File.open("store.json", "w") { |json| json.write("[]") }
    movies = Movies.new("store.json")
    movies.import_csv("data.csv")

    assert_equal "Some Title", movies.all.first["title"]
    assert_equal ["genre 1", "genre 2"], movies.all.first["genre"]
    assert_equal 23.6, movies.all.first["gross"]
  end
end