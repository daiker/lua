#!/home/scybzdk/git/skynet/skynet/3rd/lua/lua
--[[
        ################# chap1 开始 ###################################################
--]]
print("[日志 " .. os.date("%Y-%m-%d %X") .. " --chap 1 " .. "开始]")  --打印系统当前日期 时间

local config_name = "config"
local f = assert(io.open(config_name))
local str = assert(f:read "*a")
--print(str)

print(string.gsub("hello, up-down!","%A",".")) 

local function getenv(name) print(name)  return assert(os.getenv(name), "os.getenv() failed: " .. name) end
code ,res = string.gsub(str, "%$([%w_%d]+)", getenv)
f:close()
local result = {}
print("---------------------\n")
print(code,res)

assert(load(code,"=(load)","t",result))()
print("=====================\n")

for k,v in pairs(result) do
	print(k,v)
end

print(string.len("ab\x34cd"))

host = "192.168.5.106:8888"
host, port = string.match(host, "([^:]+):(.+)$")
port = tonumber(port)
print("host: ",host)
print("port: ",port)


function factor(n)
	if n == 0 then
		return 1
	elseif n > 0 then
		return n*factor(n-1)
	else
		return n
	end
end

--print("Enter a number:")
--a = io.read("*n")
--print(factor(a))

--fi=io.input("hh.c")
--b=io.read("*all")
--print(b)
--io.output("hh.c")

--io.write("hhhh xxxx\n")
--io.write("hhhh yyyy\n")
--io.write("hhhh zzzz\n")
--io.write("hhhh wwww\n")

a = 2
b = 5
while a<b do
	if a<b then
		a = a+1
		goto continue
	end
	::continue::
	print(a)
end

f = string.find
a = {"hello","ll"}
print(f(table.unpack(a)))
print(table.unpack(a))
local c = {101,102,103,104} 
print(string.char(table.unpack(c)))

network = {
        {name = "arauna",    IP = "210.26.20.30"},
        {name = "brraial",   IP = "210.26.45.33"},
        {name = "lua",       IP = "210.45.34.56"},
        {name = "derain",    IP = "210.26.23.76"},
}

table.sort(network,function (a,b) return (a.name > b.name) end)
--table.sort(network)
for k,v in pairs(network) do
	print(k,v.name)
end 


--迭代器遍历链表
local function getnext(list,node)
    if not node then
        return list          --返回list头
    else
        return node.next     --返回下一个list
    end
end

function traverse(list)
    return getnext , list , nil  --控制变量为nil
end

--[[
local list = nil
print("begin lines")
fi = io.input("hh.c")
for line in fi:lines() do
    list = {val = line, next = list }
end

print("after lines")
for node in traverse(list) do
    print(node.val)
end

i  =  32
local i = 0
f = load("i = i + 1 ; print(i)")             -- 字符串，访问的是全局  i
g = function() i = i + 1 ;print(i) end  -- 函数块，访问的是local  i
f()          --> 33
g()         --> 1
--]]


function printResult(a)
    for i=1,#a do
        io.write(a[i]," ")
    end
    io.write("\n")
end

function permgen(a,n)
    n = n or #a                --默认的n是数组a的大小
    if n <= 1 then             --只有一个元素，不需要排列
        --printResult(a)
		coroutine.yield(a)
    else
        for i = 1,n do
            a[n],a[i] = a[i],a[n]    --把第i个元素放在最末尾
            permgen(a,n-1)           --用余下的元素产生排列
            a[n],a[i] = a[i],a[n]    --恢复第i个元素
        end
    end
end

function permutations(a)		--协同程序迭代器普通版
	local co = coroutine.create(function() permgen(a) end)
	return function()
		local code,res = coroutine.resume(co)
		return res
	end 
end 
function permutation(a)		--协同程序迭代器升级版
	return coroutine.wrap(function() permgen(a) end)
end 


for p in permutation{"a","b","c"}do
	printResult(p)
end


print("end ok")

