# Movies

This class follows 'closely' the basic operations of a CRUD application (Create, Read, Update and Delete). It uses a JSON file as the Data Store and keep that file updated all the time.

When initialize, a storefile is given representing the filename of a json file. The `@id` instance variable should be used to keep track of the id count so every movie has a unqiue id.

About the methods:

- `all`: This should read the json file, parse the information and return an Array of hashes.
- `find`: This one receive an id. First the method read all the data from the json file (you can use the method `all`for this) and then try to find the movie hash that has the given ID. It returns the found hash or nil.
- `create`: This method receive a movie (a hash). It adds to the movie hash a new key ("id") with the next available id number. Then, it reads all the movies (you can use the method `all`), push the new movie to the array and store the result on the json storefile (overrides the previous one). This method should return the movie hash created (the one containing the new ID).
- `delete`: This method receive an ID. First, it reads `all` the data from te json file. The it creates a new array filtering or selecting all the movie hashes that has a different ID number. Finally, the new array is stored on the json file.
- `update`: This method receive an ID and a hash `new_data`. The new_data could have one or more keys. It is up to the user which keys they want to change. So, first the method `find` the objective hash using the ID. Then, it "merge" that hash with the new_data. Then it `deletes` the movie hash from the json file. Finally, it reads the json file, push the modify movie to the array and store the result on the json file. This method should return the movie hash updated.
- `delete_all`: This just stores an empty array ([]) on the json storefile.
- `import_csv`: This method receive a filename (a csv file is expected). It reads the CSV file and for each row it `creates` a new hash movie (the create method take care of adding the neccesary IDs)
