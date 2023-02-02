
# CCTextFormat
 A test of creating a text file format for computercraft

### Functions:
* create{fileName: string}
* append{color: int(0-15), background: int(0-15), character: int(from charset)}
* dumpBody()
* dumpHeaders()
* retrieve(n: int, start: int)
* save()

### Usage:
* #### Create new file:
	```testText = textformat.create{fileName="testText"}``` 
* #### Append character to file:
	```testText:append{color=15, backgronud=0, character=97}```
* #### Show body contents:
	```testText:dumpBody()```
* #### Show header contents:
	```testText:dumpHeaders()```
* #### Retrieve character information: 
	```testText:retrieve(4, 1)```
* #### Save file:
	```testText:save()```

### Text File Format Specification:

* ### Headers:
	* Date Created
	* Date Modified
	* Date Accessed
	* Machine of Origin
	* Version Number
	* File Size

* ### Body:
	* Text Contents
	* Color Contents
	* Highlight Color Contents

### Header Specification: - 96 bits
* Date Format: (YYYY/MM/DD hh/mm/ss) - 48 bits
	* Year			- 8 bits
	* Month			- 8 bits
	* Day			- 8 bits
	* Hour			- 8 bits
	* Minute		- 8 bits
	* Second		- 8 bits
	* File Size 		- 32 bits
	* Machine or Origin 	- 16 bits

### Body Specification:
* Body contains string of all characters
* Charset:
	* 256 Characters
	* https://imgur.com/ka5c7iF
* Character:
	* Background	- 4 bits
	* Color		- 4 bits
	* Character	- 8 bits


<table>
	<tr>
		<td><---- 8 bits ----></td>
	</tr>
	<tr>
		<td>Created Year</td>
		<td>Created Month</td>
		<td>Created Day</td>
		<td>Created Hour</td>
	</tr>
	<tr>
		<td>Created Minute</td>
		<td>Created Second</td>
		<td>Modified Year</td>
		<td>Modified Month</td>
	</tr>
	<tr>
		<td>Modified Day</td>
		<td>Modified Hour</td>
		<td>Modified Minute</td>
		<td>Modified Second</td>
	</tr>
	<tr>
		<td>Accessed Year</td>
		<td>Accessed Month</td>
		<td>Accessed Day</td>
		<td>Accessed Hour</td>
	</tr>
	<tr>
		<td>Accessed Minute</td>
		<td>Accessed Second</td>
		<td colspan=2>Machine Origin</td>
	</tr>
	<tr>
		<td>Version no.</td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td colspan=4>File Size</td>
	</tr>
</table>
