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
	print(n)
end









bt = os.clock()
print("run time : " .. bt .. " - " .. at .. " = " .. bt-at .. "s")
--[==[
	####################### chap15 模块与包 ##########################################
--]==]
print("[日志 " .. os.date("%Y-%m-%d %X") .. " --chap 15 " .. "模块与包]")  --打印系统当前日期 时间


