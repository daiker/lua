local socket = require "socket"
local http = require "socket.http"

print("socket version: " .. socket._VERSION)
local host1 = "www.baidu.com"
local file = "/ "

local host = "www.lua.org"
local file1 = "/ftp/lua-5.3.3.tar.gz "
local file2 = "/ftp/lua-5.3.2.tar.gz "
local file3 = "/ftp/lua-5.3.1.tar.gz "
local file4 = "/ftp/lua-5.3.0.tar.gz "
local file5 = "/ftp/lua-5.2.4.tar.gz "
local file6 = "/ftp/lua-5.2.3.tar.gz "
local file7 = "/ftp/lua-5.2.2.tar.gz "
local file8 = "/ftp/lua-5.2.1.tar.gz "
local file9 = "/ftp/lua-5.2.0.tar.gz "

local HTTP = "HTTP/1.0\r\nUser-Agent: Wget/1.12 (linux-gnu)\r\nAccept: */*\r\nHost: www.lua.org\r\nConnection: Keep-Alive\r\n\r\n"

local am = os.time()
local at = os.clock()

function receive(connection)
	connection:settimeout(0)	--设置为非阻塞
	local s,status,partial = connection:receive(2^10)
	if status == "timeout" then
		coroutine.yield(connection)  --超时就挂起
	end
	return s or partial,status
end 

function download(host,file)
	local sock = assert(socket.connect(host,80))
	local count = 0			--记录接收到的字节数
	sock:send("GET " .. file ..  HTTP)
	repeat
		local chunk,status = receive(sock)
		count = count + #chunk
	--	print(file,count)
	until status == "closed"
	sock:close()
	print("ok:",file,count)
end

threads = {} --保存活跃线程的表
function get(host,file)
	local co = coroutine.create(function() --创建协同程序
		download(host,file)
	end)
	table.insert(threads,co)	--插入列表
end 

function dispatch_old()
	local i = 1
	while true do 
		if threads[i] == nil then		--没有线程了
			if threads[1] == nil then break end --表是空表
			i = 1 						--重新开始循环
		end
		local status,res = coroutine.resume(threads[i]) --唤醒改线程继续下载文件
		if not res then 			--线程是否已经完成了任务
			table.remove(threads,i) --移除list中第i个线程
		else
			i = i + 1 				--检查下一个线程
		end
	end
end

function dispatch_new()
	local i = 1
	local timedout = {}					--Recvt 集合
	while true do 
		if threads[i] == nil then		--没有线程了
			if threads[1] == nil then break end --表是空表
			i = 1 						--重新开始循环
			timedout = {}				--遍历完所有线程，开始新一轮的遍历
		end
		local status,res = coroutine.resume(threads[i]) --唤醒该线程继续下载文件
		if not res then 			--线程是否已经完成了任务
			table.remove(threads,i) --移除list中第i个线程
		else
			i = i + 1 				--检查下一个线程
			timedout[#timedout +1] = res
			if #timedout == #threads then --所有线程都阻塞了吗？
				socket.select(timedout)	--如果线程有数据，就返回
			end
		end
	end
end

get(host,file1)
get(host,file2)
get(host,file3)
get(host,file4)
get(host,file5)
get(host,file6)
get(host,file7)
get(host,file8)
get(host,file9)

dispatch_new() --main loop


local bt = os.clock()
local bm = os.time()
print("bm -am :",bm,"-",am,"=",bm-am)
print("run time : " .. bt .. " - " .. at .. " = " .. bt-at .. "     " , os.difftime(bm,am) ,"s")

