#! /home/scybzdk/git/skynet/3rd/lua/lua
--[[打印二进制内容
local f = assert(io.open("./src/mylib.c","rb"))
local block = 16 
while true do 
	local bytes = f:read(block)
	if not bytes then break end 
	for _,b in ipairs {string.byte(bytes,1,-1)} do 
		io.write(string.format("%02X ",b))  --打印16个字节长的二进制数据
	end 
	io.write(string.rep(" ",block - string.len(bytes)))
	io.write(" ",string.gsub(bytes,"%c","."),"\n")
end 
--]]

package.cpath = "lib/?.so"


local powe = require "power"

--print(square(1.5))
--print(cube(5))
powe.cube(3)



function foo(a,b,c)
	print(a,b,c)
	a = a or 0
	b = b or 0
	c = c or 0
	return a + b + c
end 


