# jsaver
 A lightweight collection of functions for working with JSON in FiveM.
 
 ## Description
Jsaver allows you to store information locally in JSON files without having to create any tables in a database. This script is useful for storing persistent information of all kinds related to the server and accessing it very intuitively through LUA tables.

# Usage
This is an example with a data space called `plate'
## Create Data Space
```lua
--First we have to create the data space
if not exports['jsaver']:Exists('plates') then
    exports['jsaver']:Create('plates')
end
```
## Load data into script
```lua
--Once we have created our data space, we simply have to save it in an array
Data = exports['jsaver']:Load('plates')
```
From this point we can work with the table in THE WAY WE WANT
We can handle this array just like a map, a vector, a matrix... WHATEVER YOU WANT

## Save your information safety
```lua
--There are two ways to save the data
--First way
exports['jsaver']:Set('plates', Data)
exports['jsaver']:Save('plates')

--Second way
exports['jsaver']:Save('plates', Data)

--Third way (Only setting the information, jsaver every one minute store the changed information)
ports['jsaver']:Set('plates', Data)
```
