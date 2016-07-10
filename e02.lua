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
	print(file:read("*a"))  --为了兼容Lua5.1才加上“*”
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

local t = {"daiker","554"};

for k,v in pairs(t) do
        print("k=" .. k ..",v=" .. v);
end

function dieDaiQi(t) --迭代器
        local i = 0;
        return function()
          i = i+1;
          return t[i];
        end
end

local iter = dieDaiQi(t);
while true do
        local value = iter();
        if value == nil then
                break;
        end

        print("t=" .. value);
end



function values(t)
	local i = 0
	return function() i = i+1  return t[i] end  --只返回一个值
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

for v  in values(t) do
	print("v: " .. v)
end 

local linn = "scybzdk"

print(string.sub(linn,2,5))

function allwords()
	
	--//local file,err = io.open(name,"r")
	--assert(file)
	--local line = file:read("l")
	--local line = io.read()
	local line = "abc adk zdk "
	local pos = 1
	print("line 1",line)
	return function()
		--print("line 2",line)
		while line do
			--print("line 3",line)
			local s,e = string.find(line,"%w+",pos)
			print("line 4",line)
			if s then
				pos = e +1 
				print("line 5",line)
				return string.sub(line,s,e)
			else
				--line = file:read("l")
				print("line rrrrrrrrr",line)
				--line = io.read()
				line = "daiker daiker222 "
				line = nil
				pos = 1
			end
		end
		return nil
	end
end 
for i,v in allwords() do
	print ("i  v ",i,v)
end 

print()



	

--[==[
	####################### chap8 编译 执行 错误 ##########################################
--]==]
print("[日志 " .. os.date("%Y-%m-%d %X") .. " --chap 8 " .. "编译 执行 错误]")  --打印系统当前日期 时间





--[==[
	####################### chap9 协同程序 ##########################################
--]==]
print("[日志 " .. os.date("%Y-%m-%d %X") .. " --chap 9 " .. "协同程序]")  --打印系统当前日期 时间




--[==[
	####################### chap10 实例 ##########################################
--]==]
print("[日志 " .. os.date("%Y-%m-%d %X") .. " --chap 10 " .. "实例]")  --打印系统当前日期 时间


--[==[
	####################### chap11 数据结构 ##########################################
--]==]
print("[日志 " .. os.date("%Y-%m-%d %X") .. " --chap 11 " .. "数据结构]")  --打印系统当前日期 时间

a = {}
for i=1,5 do
	a[i] = 1   --print(a[0])  --> nil  lua中习惯用1作为起始索引
end 
print(#a)  --table 数组的总长度
for i,v in pairs(a) do
	print(i,v)
end 

--由于table是动态的实体，所以在LUA中实现链表是很方便的
list = nil
list = {next = list,value = "v"}
-- 遍历此列表
local l = list
while l do 
	print("list value:",l.value)
	l = l.next
end


--[==[
	####################### chap12 数据文件 ##########################################
--]==]
print("[日志 " .. os.date("%Y-%m-%d %X") .. " --chap 12 " .. "数据文件]")  --打印系统当前日期 时间

local mode = {}
function Module(b) 
	if b.name then
		mode[b.name] = true 
	end
end
---[[ data 文件
Module{
	name 			= "video",
	frame_rate 		= 25,
	frame_type 		= "H264",
	frame_rate 		= 2048,
	frame_interval 	= 30,
	frame_control 	= "vbr", -- cbr
}

Module{
	name 			= "audio",
	audio_type 		= "acc",
	sampling_rate 	= 8000,	 --采样率
	audio_channel 	= "stereo", --立体声
}

Module{
	name 			= "gb",
	audio_type 		= "acc",
	sampling_rate 	= 8000,	 --采样率
	audio_channel 	= "stereo", --立体声
}

Module{
	name 			= "onvif",
	audio_type 		= "acc",
	sampling_rate 	= 8000,	 --采样率
	audio_channel 	= "stereo", --立体声
}
--]]
for name,v in pairs(mode) do print("module : " .. name,v) end

--串行化
function serialize(o)
	if type(o) == "number" then
		io.write(o)
	elseif type(o) == "string" then
		--io.write("'",o,"'")
		--io.write("[[",o,"]]")  --避免特殊字符（引号，换行）
		io.write(string.format("%q",o)) --避免特殊字符" ]] " 和“ [[ "
	elseif type(o) == "table" then
		io.write("{\n")
		for k,v in pairs(o) do
			io.write(" ",k, " = ")  --适合美观的配置文件
			--io.write("  [");serialize(k);io.write("] = ")  --更加健壮，但是影响美观
			serialize(v)
			io.write(",\n")
		end
		io.write("}\n")
	else
		error("cannot serialize a " .. type(o))
	end
end 
serialize{name="video",b='Lua',key='another one'}
serialize{
	name 			= "video",
	frame_rate 		= 25,
	frame_type 		= "H264",
	frame_rate 		= 2048,
	frame_interval 	= 30,
	frame_control 	= "vbr", -- cbr
}
--保存带环的table 以后再回来细看，这次粗略地看一下，没看懂

--[==[
	####################### chap13 元表与方法 ##########################################
--]==]
print("[日志 " .. os.date("%Y-%m-%d %X") .. " --chap 13 " .. "元表与方法]")  --打印系统当前日期 时间

--任何table都可以作为任何值的元表
--在Lua代码中，只能设置table的元表，若要设置其他类型的值的元表，则必须用C代码来完成
--标准的字符串程序库为所有的字符串都设置了一个元表
print(getmetatable("hi"))  -- 打印 table: 0x8c4f1a0

Set = {}		--这个table用来保存函数
local mt = {}  --这个是集合的元表

function Set.new(l)
	local set = {}
	setmetatable(set,mt)    --第二版
	for _, v in ipairs(l) do 
		set[v] = true
	end
	return set 
end 

function Set.union(a,b)
	if getmetatable(a) ~= mt or getmetatable(b) ~= mt then
		error("attempt to 'add' a set with a non-set value",2)
	end
	local res = Set.new{}
	for k in pairs(a) do res[k] = true end
	for k in pairs(b) do res[k] = true end
	return res
end 

function Set.intersection(a,b)
	local res = Set.new{}
	for k in pairs(a) do
		res[k] = b[k]
	end
	return res
end

function Set.tostring(set)
	local l = {}
	for e in pairs(set) do
		l[#l + 1] = e 
	end
	return "{" .. table.concat(l,", ") .. "}"
end


function Set.print(s)
	print(Set.tostring(s))
end 

s1 = Set.new{10,20,30,50}
s2 = Set.new{30,1}
print(getmetatable(s1))
print(getmetatable(s2))

mt.__add = Set.union

s3 = s1 + s2
Set.print(s3)  -- > {1,20,30,10,50}

mt.__mul = Set.intersection
Set.print((s1+s2) * s1)  -- >{20,50,30,10}
-- 除了__mul , __add，每种算术操作符都有对应的字段名
--例如：__sub（减法）,__div,__unm（相反数）,__mod（取模）,__pow(取幂)

s = Set.new{1,2,3}
--s = s + 8  --8 没有元表，会报错


--元表可以指定关系操作符的含义，元方法为__eq（等于）__lt（小于） __le（小于等于）。
--其他大于等于都将转换为上诉三种方法 a > b --> b<a 

mt.__le = function(a,b)
	for k in pairs(a) do
		if not b[k] then 
			return false
		end
	end
	return true
end 

mt.__lt = function(a,b)
	return a <= b and not (b <= a)
end 

mt.__eq = function(a,b)
	return a <= b and b <= a
end 

s1 = Set.new{2,4}
s2 = Set.new{4,10,2}
print("s1 : s2")
Set.print(s1)
Set.print(s2)
print("s1 <= s2 :",s1 <= s2)
print("s1 < s2 :",s1 < s2)
print("s1 > s2 :",s1 > s2)
print("s1 >= s2 :",s1 >= s2)
print("s1 == s2 * s1:",s1 == s2 * s1)  -- 相乘是找交集
print("s2 == s2 * s1:",s2 == s2 * s1)

print({})  -- print 总是调用tostring来格式化其输出，会检查该值是否有一个__tostring的元方法。有则调用
mt.__tostring = Set.tostring  --设置元表中的tostring字段，此后调用print就会调用Set.tostring 直接打印
print("s1 : s2")
print(s1)
print(s2)

--为了保护元表，使用户不能修改集合的元表，只需要设置该字段
mt.__metatable = "Not your business,can't change a protected metatable"
print(getmetatable(s1))
--setmetatable(s1,{})这里不能调用该设置函数，会打印cannot change a protected metatable

--table访问的元方法，有两种可以改变的table行为：查询table及修改table中不存在的字段
--__index 元方法 ，一个有关继承的典型示例，__index元方法用于继承是很普通的方法
Window = {}
Window.prototype = {x=0,y=0,width=100,height=200}
Window.mt = {}
function Window.new(o)
	setmetatable(o,Window.mt)
	return o
end 

--定义__index元方法 ，__index元方法不必一定是一个函数，可以是一个table
--当是一个函数时，Lua以table和不存在的key为参数
--当它是一个table时，Lua就以相同的方式来重新访问这个table
Window.mt.__index = function(table,key)
	return Window.prototype[key]
end 

w = Window.new{x = 10,y = 20}
print(w.width)  --查询它没有的字段，结果是100

--当__index是一个table时，Lua就以相同的方式来重新访问这个table
--Window.mt__index = Window.prototype  --没有搞懂，为啥打印是nil呢？？？，以后再回来看吧
y = Window.new{x = 10,y = 20}
print(y.height)  --查询它没有的字段，结果是100


--__newindex元方法与__index类似，前者用于table的更新，后者用于table的查询
--当对一个table中不存在的索引赋值时，就会查找__newindex元方法。
--具有默认值的table
function setDefault(t,d)
	local mt = {__index = function () return d end}  --快速定义一个元方法
	setmetatable(t,mt) --设置元表
end 
tab = {x=10,y=20}
print(tab.x,tab.z)
setDefault(tab,5)  --对任何对tab中存在字段的访问都将调用它的__index元方法。
print(tab.x,tab.z,tab.xxxx)  -- --> 10 5 5

--跟踪table的访问，可以用__index和_newindex
t = {} --原来的table(在其他地方创建的)
local _t = t --保持对原table的一个私有访问

--创建代理
t = {}

--创建元表
local mt = {
	__index = function(t,k)		--
		print("*access to element " .. tostring(k))
		return _t[k] --访问原来的table
	end,
	__newindex = function(t,k,v)  --对一个不存在的索引值赋值时，会找这个元方法
		print("*update of element " .. tostring(k) .. " to " .. tostring(v))
		_t[k] = v --更新原来的table
	end
	
}
setmetatable(t,mt)


t[2] = "hello"   -- 调用 __newindex
print(t[2])		-- 调用 __index

--只读的table
function readOnly(t)
	local proxy = {}
	local mt = {
		__index = t,
		__newindex = function(t,k,v)
			error("attempt to update a read-only table",2)
		end
	}
	setmetatable(proxy,mt)
	return proxy
end 

days = readOnly{"Sunday","monday","Tuesday","Wednesday",
				"Tuesday","Friday","Saturday"}
print(days[1])
--days[2] = "Noday"  --这样去访问会导致error抛出错误,这个可以用于以后的系统配置文件，不让客户去修改 gooooooood ^_^


--跟踪table，__index和__newindex都是在table中没有所需访问的index时才发挥作用
--因此，只有将一个table保持为空，才能捕捉到所有对它的访问
--其次要为真正的table创建一个代理，并且为空 ， ------重定向到原来的table







--[==[
	####################### chap14 环境 ##########################################
--]==]
print("[日志 " .. os.date("%Y-%m-%d %X") .. " --chap 14 " .. "环境]")  --打印系统当前日期 时间
--Lua将其所有的全局变量保存在一个常规的table中，这个table为“环境”

for n in pairs(_G) do
	--print(n)  打印所有的全局变量
end

setmetatable(_G,{
	__newindex = function(t,n,v)
		--error("[Waring]::::::attempt to write to undeclared variable " .. n,2)
		--print("[Waring]::::::attempt to write to undeclared variable V1")
		--print("[Waring]::::::attempt to write to undeclared variable V2")
		local w = debug.getinfo(2,"S").what
		print("write what : ",w)
		if w ~= "main" and w ~= "C" then   --主函数就绕过error
			error("attempt to write to undeclared variable " .. n,2)
		end 
		rawset(t,n,v)
	end,
	__index  = function(_,n)
		local w = debug.getinfo(2,"S").what
		print("read  what : ",w)
		if w ~= "main" and w ~= "C" then   --主函数就绕过error
			error("attempt to read undeclared variable " .. n,2)
		end
		--print("[Waring]::::::attempt to read undeclared variable ")
	end,
})
m = 0		--打印警告,调用__newindex元方法
print(n)  --打印警告,调用__index元方法


-- 通过rawset 可以绕过元表，这里没有测试通过，还不知道什么原因，总是会去调用__newindex,以后再回来看吧
--function declare(name,initval)
	--rawset(_G,name,initval or false)
--end 

--非全局的环境，可以通过函数setfenv来改变一个函数的环境，参数可以是函数和一个新的环境table
--如果第一个参数为数字1，就表示当前函数，为2就表示调用当前函数的函数

if _VERSION == "Lua 5.1" then
	a = 10
	--setfenv(1,{g = _G})  -- 调用此函数后导致下面的函数调用都找不到定义了，这个函数只在Lua5.1里才有，5.2版本以后都删除掉了
	print(a)

	
	--[==[
		####################### chap15 模块与包 ##########################################
	--]==]
	print("[日志 " .. os.date("%Y-%m-%d %X") .. " --chap 15 " .. "模块与包]")  --打印系统当前日期 时间
else 
	
	--[==[
		####################### chap15 模块与包 ##########################################
	--]==]
	print("[日志 " .. os.date("%Y-%m-%d %X") .. " --chap 15 " .. "模块与包]")  --打印系统当前日期 时间
end


--以下这两个变量用于存放环境变量
print(package.path)  --根据Lua版本不同，找的路径不同
print(package.cpath)  --根据Lua版本不同，找的路径不同

--local m = require "math"
print(math.sin(3.14))
local M = {}
setmetatable(M,{__index = _G})
_ENV = M
function add(c1,c2)
	return new(c1.r + c2.r,c1.i + c2.i)
end

--_ENV = nil -- or _EVN = M  环境还没有搞懂什么原理，以后再回来
--Lua5.1 可以用这个_ENV,Lua5.3要在下面报错，没搞懂


--[==[
	####################### chap16 面向对象 ##########################################
--]==]
print("[日志 " .. os.date("%Y-%m-%d %X") .. " --chap 16 " .. "面向对象]")  --打印系统当前日期 时间

Account = {balance = 500}
function Account:withdraw(v)
	if v > self.balance then 
		error "insufficient funds"
	end 
	self.balance = self.balance -v  --也可以用冒号去定义一个方法
end 

function Account:deposit(v)
	self.balance = self.balance + v
end 

function Account:new(o)	--创建一个新账户
	o = o or {} --如果用户没有提供table，就创建一个
	setmetatable(o,self)
	self.__index = self
	return o
end

al = Account--;Account = nil
al.withdraw( al ,100) -- 必须指定其作用的对象 500 - 100
al:withdraw(100) --冒号是在一个方法定义中添加一个额外的隐藏参数 400 - 100
					--方法调用中添加一个额外的实参
-- 接下来依次创建 类，继承 ，私密性
-- 类就像是一个创建对象的模具
a = {}
b = {}
--setmetatable(a,{__index = b})  --让b作为a的一个原型
								--a 就会在b中查找所有它没有的操作 “可以称b是对象a的类”
a = Account:new{balance = 0}
a:deposit(1100.00)
b = Account:new()
print(b.balance)  -->300
b:deposit(100)
print(b.balance)  --> 400

--继承 
SpecialAccount = Account:new()
s = SpecialAccount:new{limit = 1000}
print(s.balance)  -->上面al.withdraw 减了200 ，所有结果为300
s:deposit(50)
print(s.balance)  -->350

--当然，也可以重新定义一个新方法withdraw
function SpecialAccount:withdraw(v)
	if v - self.balance >= self:getLimit() then
		error ("insufficient funds : draw: " .. v .. " - " .. self.balance)
	end
	self.balance = self.balance - v 
end 

function SpecialAccount:getLimit()
	return self.limit or 0
end 
print("s begin draw.......")
 s:withdraw(100)
print(s.balance)  -->250
function s:getLimit()
	return self.balance * 0.10
end 
s:withdraw(100) 
print(s.balance) -->150
s:withdraw(100)
print(s.balance) -->50

--多重继承
--用一个函数作为__index元字段

--私密性
function newAccount(initialBalance)
	local self = {balance = initialBalance, --用于保存对象的内部状态
				LIM = 10000.00,				--这些状态以后就只能通过内部的函数来访问
				}
	local extra = function()		--任何用户都无法直接访问extra函数
		if self.balance > self.LIM then
			return self.balance * 0.10
		else
			return 0 
		end 
	end 
	local  getBalance = function()
		return self.balance + extra()
	end 
	
	
	local withdraw = function(v)
		self.balance = self.balance -v 
	end 
	local deposit = function(v)
		self.balance = self.balance + v 
	end 

	return{
		withdraw =withdraw, --将方法名与真正的方法实现匹配起来
		deposit = deposit,
		getBalance = getBalance
	}
end 

acc = newAccount(11000.00)
acc.withdraw(100)
print(acc.getBalance())

--单一方法做法
--当一个对象只有一个方法时，可以不用创建接口table，
--但是要将这个单独的方法作为对象来返回
--一个具有状态的迭代器就是一个单一方法对象

function newObjuct (value)
	return function(action,v)
		if action == "get" then
			return value 
		elseif action == "set" then 
			value = v 
		else 
			error("invalid action")
		end 
	end 
end 
d = newObjuct(5)
print(d("get"))
d("set",10)
print(d("get"))


--[==[
	####################### chap17 弱引用table] ##########################################
--]==]
print("[日志 " .. os.date("%Y-%m-%d %X") .. " --chap 17 " .. "弱引用table]")
--弱引用，一种会被垃圾收集器忽视的对象引用
--如果一个对象只被一个弱引用table所持有，那么最终Lua会回收这个对象
--三种弱引用table：具有弱引用key的table、具有弱引用value的table、同时具有两种弱引用table
--只要有一个key或value被回收了，它们所在的整个条目都会从table中删除
--一个table的弱引用类型是通过元表中的__mode字段来决定的
--__mode 中包含字母'k',那么这个table的key是弱引用
--__mode 中包含字母'v',那么这个table的value是弱引用,__mode = "kv" 表示key和value都是弱引用
a = {}
b = {__mode = "k"}
setmetatable(a,b)  --此时a有一个weak keys
key = {}		  --创建第一个key
a[key] = 1
key = {}			--创建第二个key
a[key] = 2
--collectgarbage()	--强力回收
for k,v in pairs(a) do
	print(v)
end	

collectgarbage()	--forces a garbage collection cycle
for k,v in pairs(a) do
	print(v)
end


--备忘录函数，优化节省时间，再加上弱引用table就完美了
local results = {}


setmetatable(results,{__mode = "v"}) --使key和value成为弱引用

function mem_loadstring(s)
	local res = results[s]
	if res == nil then			--是否记录过
		res = assert(loadstring(s))--计算新结果
		results[s] = res 		--保存备份，以备用
	end 
	return res
end

function createRGB(r,g,b)
	local key = r .. "-" .. g .. "-" .. b
	local color = results[key]
	if color == nil then 
		color = {red = r,green = g,blue = b}
		results[key] = color
	end
	return color
end 

--对象属性


--[==[
	####################### chap18 数学库] ##########################################
--]==]
print("[日志 " .. os.date("%Y-%m-%d %X") .. " --chap 18 " .. "数学库]") 

print(math.random(100))
print("----->")
math.randomseed(os.time())  --设置伪随机数生成器的种子数
print(math.random(100))
print()

--以下是Lua程序设计第三版中的内容
--位操作
function printx(x)
	print(string.format("0x%x",x))
end 
--按位操作中的操作符“band”,"bor","bnot" 在Lua5.2中废弃了bit32库,5.3中直接使用操作符
print(_VERSION)
if _VERSION == "Lua 5.1" then
	
	print(10/3)		-->3.3333333333333
else
print("以下异或操作被屏蔽")
--[[  以下只能 Lua 5.3 能用
	printx(2&3)	-->与 2
	printx(4|1)	-->或 5
	printx(2~1)	-->二元，异或	3
	printx(~1)	-->一元，按位非0xfffffffffffffffe
	printx(2^3)		-->2的3次方  8
	printx(10%3)	--取模
	printx(10//3)	--取整除   3
--]]
end
--以上是Lua程序设计第三版中的内容，但是在5.3中才能使用

--[==[
	####################### chap19 table库] ##########################################
--]==]
print("[日志 " .. os.date("%Y-%m-%d %X") .. " --chap 19 " .. "table库]") 

t= {10,20,30}
table.insert(t,1,5)  --如果没有指定位置参数，则添加到末尾，等价于压入
for k,v in ipairs(t) do
	print(k,v)
end

table.remove(t,3 )--如果没有指定位置参数，则删除末尾最后一个，等价于弹出
for k,v in ipairs(t) do
	print(k,v)
end

--排序，必须针对数组才行
ines = {
	luaH_set = 10,
	luaH_get = 24,
	luaH_abc = 55,
	luaH_present = 48,
}
local a = {}
for n in pairs(ines) do
	print(n)		--这里打印是无序的
	a[#a + 1] = n 
end 
print('------after sort-----')
table.sort(a)
for i,n in ipairs(a) do 
	print(n)		--这里打印是按序的
end 
print('------end sort-----')



--连接，针对字符串数组
function rconcat(l)
	if type(l) ~= "table" then 
		return l 
	end 
	local res = {}
	for i=1,#l do
		res[i] = rconcat(l[i]) --递归调用，连接所有可能嵌套的字符串数组
	end 
	return  table.concat(res)
end 	
print(rconcat{{"a",{" nice"}}," and",{{" long"},{" list"}}})

--[==[
	####################### chap20 字符串库] ##########################################
--]==]
print("[日志 " .. os.date("%Y-%m-%d %X") .. " --chap 20 " .. "字符串库]") 

--lua中真正的字符串操作能力来源于字符串库,字符串索引-1表示最后一个字符
s = "[in brackets]"
print(string.sub(s,2,-2)) --sub不会改变字符串的值，只会返回一个新字符串

print(string.char(97))			--打印 a 
i=99				
print(string.char(i,i+1,i+2))	--cde
print(string.byte("abc"))		--97 打印第一个数值
print(string.byte("abc",2))		--98
print(string.byte("abc",-1)) 	--99
print(string.byte("abc",1,2))	--97	98

print(string.format("pi = %.4f",math.pi))

--最强大的函数、find、match、gsub(global substitution,全局替换)和gmatch(全局匹配)
s = "hello world"
i,j = string.find(s,"hello")  --它可以接受第三个参数，表示下次查找的开始位置
print(i,j)
print(string.sub(s,i,j))

--gmatch返回的不是j,j的位置，而是返回字符子串
print(string.match(s,"llo"))

local dat = "Today is 10/7/2016"
d = string.match(dat,"%d+/%d+/%d+")   --模式匹查找
print(d)
--查找并替换，还有第四个参数，可以限制替换次数
s = string.gsub("Lua is cute","cute","great")
print(s)
s = string.gsub("all lii","l","x")
print(s)
s = string.gsub("Lua is great","Sol","Sun")
print(s)
print("------------replace limit---l-->x ------")
s = string.gsub("all lii","l","x",1)
print(s)
s = string.gsub("all lii","l","x",2)
print(s)
str = "hello world this is Lua language learn"--gsub有一个额外的功能，是统计替换的次数
count = select(2,string.gsub(str," "," ")) --select返回从第二个参数开始的参数
print(count)

s = "hello 12 wo.rld fr.om lua 123"
for w in string.gmatch(s,"%a+") do   --%a+是匹配一个或多个字母
	print(w)
end 

s =  string.gsub(s,"%.","/")    --%a+是匹配一个或多个字母
	print(s)




--一个用gmatch 和gsub模拟require在寻找模块
function search(modname,path)
	modname =  string.sub(modname,"%.","/")--用'/'替换所有的'.'，这里要加'%'，应为点有特殊含义
	for c in sting.gmatch(path,"[^;]+") do  --遍历不包括分号的子串，[]表示字符集
		local fname = string.gsub(c,"?",modname) --用模块名替换问号，但是这里的名字不是包含'/'吗？没搞懂
		local f = io.open(fname)
		if f then 
			f:close()
			return fname
		end 
	end 
	return nil -- 没找到
end 


--模式
print(string.gsub("hello, up-down!","%A",".")) --大写A表示所有匹配符的补集

--魔法字符 () . % + - * ? [ ] ^ $ 
--用‘%’来转义这些魔法字符
--^作为模式的起始，则只会匹配目标字符串的开头部分，
--‘$’结尾，则只会匹配目标字符串的结尾部分
-----“^[+-]?%d+$”表示字符串是否表示一个整数，并且没有多余的前导字符和结尾字符
--%b可以表示匹配成对的字符，%b()表示以‘(’开始，以 ')'结束的字串,典型用于%b[],%b{},%b<>
s = "a (enclosed (in) parentheses) line"
print(string.gsub(s,"%b()",""))
--在字符集中表示一段字符范围的方法是如[1-9]，[a-f]
-- + 表示重复1次或多次
-- * 表示重复0次或多次，尽可能多
-- - 表示重复0次或多次, 尽可能少
-- ？可选部分(0次或1次) ，[+-]?%d+ 就可以表示正负数了
print(string.gsub("one ,and two; and three","%a+","word"))
print(string.match("the number 1298 is even","%d+"))

--捕获
 pair = "name = Anna"
 key,value = string.match(pair,"(%a+)%s*=%s*(%a+)")
 --"%a+"表示一个非空的字母序列，“%s*”表示一个可能为空的空格序列
 print(key,value)

date = "Today is 10/7/2016"
d,m,y =  string.match(date,"(%d+)/(%d+)/(%d+)")
print(y,m,d)








local bt = os.clock()
print("run time : " .. bt .. " - " .. at .. " = " .. bt-at .. "s")
--[==[
	####################### chap21 IO库] ##########################################
--]==]
print("[日志 " .. os.date("%Y-%m-%d %X") .. " --chap 21 " .. "IO库]") 



