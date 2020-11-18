# CSV Parser

Complete the module `MoviesCsvParser` to transform a CSV file into a useful ruby hash and viceversa.

- `parse_csv_movies` This methos receive a filename (a csv file is expected like `movies.csv`) and transoform each line into a hash resulting on an Array of hashes.

Notice that the second column (`genre`), contains a string of multiple values separated by a ", ". Your resulting hash should have an Array of genres.

Another one, the `gross` column has a string with the dollar sign (\$) and a M at the end. You should only keep te number in your hash.

As a result, this line for example:

```
The Dark Knight (2008),"Action, Crime, Drama",$534.86M
```

Should be converted as:

```ruby
{ "title" => "The Dark Knight (2008)", "genre" => ["Action", "Crime", "Drama"], "gross" => 534,86 }
```

- `export_csv` This method receive a movies hash and a destination filename. It make exactly the opposite of the previous method. It should join the genres on a single string and add the \$ sign and the M for the gross value. The result should be store using the CSV format on the destination file.
