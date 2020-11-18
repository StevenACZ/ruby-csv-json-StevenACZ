# JSON Parser

The objective here is similar to the CSV Parser but easier 🙂 JSON is more flexible and, for example, if a movie has multiple genres JSON would use an Array directly. Is not very common to send "formatted" numbers like "\$23.60M" using json, so we will use the number directly here. In other words, no manual transformation needed.

- `parse_movies(filename)` This method receive a filename (a json file is expected) and return an array of hashes.

- `export_json(movies, filename)` This method receive an array of hashes and a destination filename. It transform the array of hashes in JSON notation and store the result in the destination filename.
