local t = {"daiker","554"};

for k,v in pairs(t) do
	print("k=" .. k ..",v=" .. v);
end

function dieDaiQi(t)
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