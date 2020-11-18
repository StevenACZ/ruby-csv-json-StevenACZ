require "json"

module MoviesJsonParser
  def parse_movies(filename)
    json_to_array_hashes(filename)
  end

  def export_json(movies, filename)
    array_hashes_to_json(movies, filename)
  end

  private

  def json_to_array_hashes(filename)
    JSON.parse(File.read(filename))
  end

  def array_hashes_to_json(movies, filename)
    File.write(filename, movies.to_json, mode: "w")
  end
end
