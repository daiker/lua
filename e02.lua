#! /home/scybzdk/git/skynet/3rd/lua/lua
--[[
	################# chap1 开始 ###################################################
--]]
print("[日志 " .. os.date("%Y-%m-%d %X") .. " --chap 1 " .. "开始]")  --打印系统当前日期 时间
local at = os.clock()
function fact(n) --阶乘
	if n == 0 then
		return 1
	else
		return n * fact(n-1)
	end
end

local t1 = os.time()
--print("enter a number:") 
--local num = io.read("*number")    -- 读取以数字开始的数值，如123ab456 -->123 ; ab123--> nil
num="20"
print("num len: " .. #num)		-- #是取字符串长度
num = tonumber(num)
if num == nil then
	print("type a nil number")
else
	print("enter numb: " .. num)
	print("enter type: " .. type(num))
end

assert(type(num) == "number")
print(fact(num))
local t2 = os.time()
--print(os.difftime(t2,t1))	--打印时间差


--[==[
	#################### chap2 类型与值 ##########################################
--]==]
print("[日志 " .. os.date("%Y-%m-%d %X") .. " --chap 2 " .. "类型与值]")  --打印系统当前日期 时间
-- 循环函数function loops and conditionals --
print("for loops")
for i=1,5 do
       -- print("i is now " .. i)
        if i < 2 then
                print(i .. " small")
        elseif i < 4 then
                print(i .. " medium")
        else
                print(i .. " big")
        end
end
j = 5
print("while loops")
while j >0 do
        print("j == " ..j)
        j = j-1
end

k = 1
print("repeat loops")
repeat
        print("k is now " ..k)
        k = k + 1
until k > 5

tab = {}
k = "X"
tab[k] = 10
tab[20] = "great"
print(tab["X"])

--语法糖,lua数组是以1作为起始索引，不像C是用0作为起始值，#tab 表示最后一个索引值（或为其大小）
tab.name = "zdk"
print(tab.name)
print(tab["name"])  --这里不能用tab[name]

--[==[
	####################### chap3 表达式 ##########################################
--]==]
print("[日志 " .. os.date("%Y-%m-%d %X") .. " --chap 3 " .. "表达式]")  --打印系统当前日期 时间

-- 表达式中还可以包含函数定义 和 table 构造

print("10%3 = " .. 10%3)

--[[
	所有关系操作符的结果都是true或者false
	所有的逻辑操作符将false 和 nil视为假
	and 和 or 都使用短路求值
	
--]]

x = 9
y = 7
big = (x>y) and x or y
print("big : " .. big)

-- 区分记录风格初始化，列表风格初始化
-- {a=1,b=2 ;"one","two","three"}  ,可以用分号把两种风格区分开，列表即数组
polyline = {color="blue",thickness=2,npoints=4,
				{x=0,y=0},
				{x=-10,y=0},
				{x=-10,y=1},
				{x=0,y=1},
			}
print(polyline[1].x,polyline[1].y)
print(polyline[2].x,polyline[2].y)
print(polyline[3].x,polyline[3].y)
print(polyline[4].x,polyline[4].y)


--[==[
	####################### chap4 语句 ##########################################
--]==]
print("[日志 " .. os.date("%Y-%m-%d %X") .. " --chap 4 " .. "语句]")  --打印系统当前日期 时间

a,b = 10,20
print("a b",a,b)
a,b = b,a
print("a b",a,b)

-- 尽可能地使用局部变量 是一种良好的编程风格
-- if for  while 以end结尾，repeat 以until结尾

if a< 0 then a=0 end
local r = 0
op = "+"

if op == "+"  then
	r = a+b
elseif op == "-" then
	r = a - b 
elseif op == "*" then
	r = a*b 
elseif op == "/" then
	r = a/b 
else
	error("invalid operation")
end
print("r = " .. r)

a = {"one",2,3,4,"five"}
local i = 1
while a[i] do
	print(a[i])
	i = i+1
end

repeat 
	line = "read line" --io.read("*number")
	until line ~= " "
print(line)

--for 有两种形式，数字型for，泛型for
for var=1,10000000,2 do   --从1到5，每次都以+2作为条件执行，控制变量为for的局部变量，表达式是一次性求值的
	a = 10 --print("for var : " .. var)
end

-- ipairs 一个遍历数组的迭代器函数,pairs 一个遍历table的迭代器函数
a = {"one",2,3,4,"five"}
b = {["one"]=11,2,3,4,["dd"]="five"}
print("")
print("ipairs a")
for k,v in ipairs(a) do print(k .. ":  " .. v) end
print("")
print("pairs b")
for k,v in pairs(b) do print(k .. ":  " .. v) end
print("")
print("ipairs b")
for k,v in ipairs(b) do print(k .. ":  " .. v) end



--break 和 return 

function foo()
		--	return  --语法错误
	do
		print("rule ok")
		return  --语法正确
	end
end
foo()


--[==[
	####################### chap5 函数 ##########################################
--]==]
print("[日志 " .. os.date("%Y-%m-%d %X") .. " --chap 5 " .. "函数]")  --打印系统当前日期 时间


function add(...)
	local s = 0
	for i,v in ipairs({...}) do
		s = s + v
	end
	return s
end

print("add sum : " .. add(1,2,3,4,5))

-- 具名实参 针对很多参数，但是只取有用的参数的情况使用

window_={x=0,y=0,width=300,height=200,
		title="Lua",background="blue",
		border=true}
function foo(...)
	for i=1,select('#',...) do  -- select('#',...) 返回所有变长参数的总和
	local arg= select(i,...)
		print("arg",arg)
	end 
	
	for i,v in pairs({...}) do
		print("aaaarg: " .. i ,v)
	end 
end
foo(0,0,300,200,"Lua","blue",true)



--[==[
	####################### chap6 深入函数 ##########################################
--]==]
print("[日志 " .. os.date("%Y-%m-%d %X") .. " --chap 6 " .. "深入函数]")  --打印系统当前日期 时间


foo = function(x)
	return 2*x
end
win = {0,0,300,200,"Lua","blue"}
network = {
			{name = "grauna",IP = "192.168.1.106"},
			{name = "arraial",IP = "192.168.2.106"},
			{name = "scybzdk",IP = "192.168.5.106"},
			{name = "derain",IP = "192.168.10.106"},
			{name = "lua",IP = "192.168.20.106"},
		}
print(table.concat(win,",")) -- 打印list中的元素

for i,v in ipairs(network) do
	print("key:" .. i ,v.name)
end

table.sort(network,function(a,b) return (a.name > b.name) end)

for i,v in ipairs(network) do
	print("key:" .. i ,v.name)
end
-- closure --闭合函数，内部fun可以访问外部fun的局部变量 闭合函数，内部fun可以访问外部fun的局部变量 称为“词法域”

function newCounter()
	local i = 0 
	return function()
		i = i + 1
		return i 
	end
end

c1 = newCounter()
c2 = newCounter()
print(c1())
print(c1())
print(c2())
print(c1())
print(c1())

-- closure 可以创建一个安全的运行环境，即所谓的“沙盒”
-- 例如可以重定义io.open，保证代码运行的安全性
do
	local oldOpen = io.open 
	local access_OK = function(filename,mode)
		print("check access OK")
		return true
	end
	io.open = function(filename,mode)  --重定义
	if access_OK(filename,mode) then
		return oldOpen(filename,mode)
	else
		return nil,"access denied"
	end
	end
end

local file,err = io.open("ip.info","w")
if file == nil then
	print(err)
else
	--print("open ok ,fd : " , file)
	--print(file:read("a"))
	file:write("zdk scybzdk 0002\n")
	file:write("zdk scybzdk 0003\n")
	file:write("zdk scybzdk 0004\n")
	--print(file:read("a"))
	file:flush()
	file:close()
end 


local file,err = io.open("ip.info","r")
if file == nil then
	print(err)
else
	print(file:read("a"))
	file:close()
end	
	
-- table中定义函数成员的三种表示方法
lib = {}
lib.foo = function(x,y) return x+y end
lib.goo = function(x,y) return x-y end

lib2 = {
	foo = function(x,y) return x+y end,
	goo = function(x,y) return x-y end,
	}
lib3 = {}
function lib3.foo(x,y) return x+y end
function lib3.goo(x,y) return x-y end

-- 在lua中，只有return func() 才算尾调用，尾调用消除可以防止栈溢出。


--[==[
	####################### chap7 迭代器与泛型for ##########################################
--]==]
print("[日志 " .. os.date("%Y-%m-%d %X") .. " --chap 7 " .. "迭代器与泛型for]")  --打印系统当前日期 时间



function values(t)
	local i = 0
	return function() i = i+1  return t[i] end
end

t = {10,20,30}
iter = values(t)
while true do
	local element = iter()
	if element == nil then
		break
	end
	print(element)
end

		






	
bt = os.clock()
print("run time : " .. bt .. " - " .. at .. " = " .. bt-at .. "s")
--[==[
	####################### chap8 编译 执行 错误 ##########################################
--]==]
print("[日志 " .. os.date("%Y-%m-%d %X") .. " --chap 8 " .. "编译 执行 错误]")  --打印系统当前日期 时间






























































