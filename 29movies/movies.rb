require_relative "../27parse_csv/parse_csv"
require_relative "../28parse_json/parse_json"

class Movies
  include MoviesJsonParser
  include MoviesCsvParser

  def initialize(storefile)
    @id = 0
    @storefile = storefile
  end

  def all
    parse_movies(@storefile)
  end

  def find(id)
    movie_find = all.select { |movie| movie["id"] == id }
    movie_find.size.zero? ? nil : movie_find[0]
  end

  def create(movie)
    new_movie = all.to_a.push(movie.to_a.push(["id", next_id]).to_h)
    export_json(new_movie, @storefile)
  end

  def update(id, new_data)
    new_movie = update_movie_data(id, new_data)
    movies = all.reject { |movie| movie["id"] == id }
    movies.push(new_movie)
    export_json(movies, @storefile)
    new_movie
  end

  def delete(id)
    movies = all.reject { |movie| movie["id"] == id }
    export_json(movies, @storefile)
  end

  def delete_all
    export_json([], @storefile)
  end

  def import_csv(filename)
    export_json(parse_csv_movies(filename), @storefile)
  end

  private

  def update_movie_data(id, new_data)
    new_movie = (all.select { |movie| movie["id"] == id })[0]
    new_movie.delete(new_data.keys[0])
    new_movie.to_a.push(new_data.to_a[0]).to_h
  end

  def next_id
    @i ||= 0
    @i += 1
  end

  def csv_to_hash(filename)
    csv_parse = []
    CSV.foreach(filename, headers: true) do |row|
      row = row.to_hash
      row["genre"] = row["genre"].split(", ")
      row["gross"] = string_to_number(row["gross"])
      row = row.to_a.push(["id", next_id]).to_h
      csv_parse.push(row)
    end
    csv_parse
  end

  def string_to_number(str_num)
    num = ""
    str_num.each_char { |char| char.match(/^[0-9|.]*$/) && num += char }
    num.to_f
  end
end
