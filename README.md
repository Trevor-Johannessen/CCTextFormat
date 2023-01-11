
# CCTextFormat
 A test of creating a text file format for computercraft

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
