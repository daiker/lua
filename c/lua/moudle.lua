#! /home/scybzdk/git/skynet/skynet/3rd/lua/lua
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
local power = require "power"

print(power.square(23))  --调用c函数
print(power.cube(4))
print(power.sin(2))
function foo(a,b)		--被c函数调用
	print(a,b)
	a = a or 0
	b = b or 0

	return a + b
end 


