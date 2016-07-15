#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"

static int isquare(lua_State *L){
	float ret = lua_tonumber(L,-1); //从栈中取出一个变量，这个变量是number类型的
	//printf("Top of square(),nbr=%f\n",ret);
	lua_pushnumber(L,ret*ret);		//把结果计算好后，将结果压回Lua栈
	return 1;						//这个返回值告诉lua虚拟机，我们往栈里放入了多少个返回值
}

static int icube(lua_State *L){
	float ret = lua_tonumber(L,-1); //从栈中取出一个变量，这个变量是number类型的
	//printf("Top of cube(),nbr=%f\n",ret);
	lua_pushnumber(L,ret*ret*ret);		//把结果计算好后，将结果压回Lua栈
	lua_pushnumber(L,ret);		//再返回一个值
	return 2;						//这个返回值告诉lua虚拟机，我们往栈里放入了多少个返回值
}

static int isin(lua_State *L){
	float d = luaL_checknumber(L,1); //检查函数的第一个参数是否是一个数字，并返回它
	lua_pushnumber(L,sin(d));
	return 1;
}

#if 0
int luaopen_power(lua_State *L){
	lua_register(	//把c函数isquare设到全局变量square中
		L,			//Lua状态机
		"square",	//Lua中的函数名
		isquare		//当前文件中的函数名
	);
	lua_register(L,"cube",icube);
	return 0;		//Lua5.1 的才会是这样返回
}
#endif

int luaopen_power(lua_State *L){
	luaL_Reg l[] = {
		{ "square", isquare },
		{ "cube", icube },
		{ "sin", isin },
		{ NULL, NULL },  //以此标识结尾
	};
	luaL_checkversion(L);
	luaL_newlib(L,l);
	return 1;			//这里必须要1，返回一个table.对于老版本的5.1就是0，没有返回任何值
}




















