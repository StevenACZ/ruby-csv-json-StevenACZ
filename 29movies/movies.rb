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
    # your code here
  end

  def find(id)
    # your code here
  end

  def create(movie)
    # your code here
  end

  def update(id, new_data)
    # your code here
  end

  def delete(id)
    # your code here
  end

  def delete_all
    # your code here
  end

  def import_csv(filename)
    # your code here
  end

  private

  def next_id
    # your code here
  end
end
