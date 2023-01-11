
local year = 125
local month = 4
local day = 6
local hour = 17
local minute = 56
local second = 32
local machineOrigin = 4
local filesize = 123456

local encoding = "I1I1I1I1I1I1I2I4" -- encoding for all header values
local encodedString = string.pack(encoding, year, month, day, hour, minute, second, machineOrigin, filesize)
print(encodedString)
print(string.unpack(encoding, encodedString))