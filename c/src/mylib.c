#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>

#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"

#define SMALLSTRING 2048
#define TYPE_DATA 1
#define TYPE_MORE 2
#define TYPE_ERROR 3
#define TYPE_OPEN 4
#define TYPE_CLOSE 5

#if 0
static int
filter_data_(lua_State *L, int fd, uint8_t * buffer, int size) {
	lua_pushvalue(L, lua_upvalueindex(TYPE_DATA));
	lua_pushinteger(L, fd);
	lua_pushlstring(L, (char *)buffer, size);
	lua_pushinteger(L, size);
	return 4;
}

static inline int
filter_data(lua_State *L, int fd, uint8_t * buffer, int size) {
	int ret = filter_data_(L, fd, buffer, size);
	// buffer is the data of socket message, it malloc at socket_server.c : function forward_message .
	// it should be free before return,
	skynet_free(buffer);
	return ret;
}

static void
pushstring(lua_State *L, const char * msg) {
	if (msg) {
		lua_pushstring(L, msg);
	} else {
		lua_pushliteral(L, "");
	}
}

/*
	userdata queue
	lightuserdata msg
	integer size
	return
		userdata queue
		integer type
		integer fd
		string msg | lightuserdata/integer
 */
static int
lfilter(lua_State *L) {
	struct skynet_socket_message *message = lua_touserdata(L,1);
	int size = luaL_checkinteger(L,2);
	char * buffer = message->buffer;
	if (buffer == NULL) {
		buffer = (char *)(message+1);
		size -= sizeof(*message);
	} else {
		size = -1;
	}

	switch(message->type) {
	case SKYNET_SOCKET_TYPE_DATA:
		// ignore listen id (message->id)
		assert(size == -1);	// never padding string
		return filter_data(L, message->id, (uint8_t *)buffer, message->ud);
	case SKYNET_SOCKET_TYPE_CONNECT:
		// ignore listen fd connect
		return 0;
	case SKYNET_SOCKET_TYPE_CLOSE:
		lua_pushvalue(L, lua_upvalueindex(TYPE_CLOSE));
		lua_pushinteger(L, message->id);
		return 2;
	case SKYNET_SOCKET_TYPE_ACCEPT:
		lua_pushvalue(L, lua_upvalueindex(TYPE_OPEN));
		// ignore listen id (message->id);
		lua_pushinteger(L, message->ud);
		pushstring(L, buffer);
		return 3;
	case SKYNET_SOCKET_TYPE_ERROR:
		lua_pushvalue(L, lua_upvalueindex(TYPE_ERROR));
		lua_pushinteger(L, message->id);
		pushstring(L, buffer);
		return 3;
	default:
		// never get here
		return 0;
	}
}

int
luaopen_httppack(lua_State *L) {
	luaL_checkversion(L);

	// the order is same with macros : TYPE_* (defined top)
	lua_pushliteral(L, "data");
	lua_pushliteral(L, "more");
	lua_pushliteral(L, "error");
	lua_pushliteral(L, "open");
	lua_pushliteral(L, "close");

	lua_pushcclosure(L, lfilter, 5);
	lua_setfield(L, -2, "filter");

	return 1;
}



#endif

lua_State *L = NULL;
static double f(double x,double y)
{
	double z;
	lua_getglobal(L,"foo");			//获取lua函数foo
	lua_pushnumber(L,x);
	lua_pushnumber(L,y);			//压入x,y

	if(lua_pcall(L,2,1,0) != 0){	//传入两个参数，1个返回值，调用函数后都会pop出栈
									//调用返回后，结果会push进栈
		fprintf(stderr, "%s:%s", __FILE__,lua_tostring(L, -1));
		lua_pop(L, 1);/* pop error message from the stack */
	}
	
	if(!lua_isnumber(L,-1)){
		fprintf(stderr, "%s", lua_tostring(L, -1));
		lua_pop(L, 1);/* pop error message from the stack */
	}
	
	z = lua_tonumber(L,-1);	//从指定索引转换出一个lua_Number值
	lua_pop(L,1);
	return z;
}

/*
	模拟一个Lua解释器
*/
int main(int argc,char **argv)
{
   // char buff[256];
    int error;
	L =luaL_newstate();  /* opens Lua */
	luaL_openlibs(L);		//调用该函数需要链接dl库，然后可以屏蔽以下各库
    //luaopen_base(L);         /* opens the basic library */
    //luaopen_table(L);        /* opens the table library */
    //luaopen_io(L);           /* opens the I/O library */
	//luaopen_string(L);       /* opens the string lib. */
	//luaopen_math(L);         /* opens the math lib. */

	printf("lua >");
	fflush(NULL);
	error = luaL_loadfile(L,"./lua/moudle.lua") || lua_pcall(L, 0, 0, 0);
	if (error) {
		fprintf(stderr, "%s", lua_tostring(L, -1));
		lua_pop(L, 1);/* pop error message from the stack */
	}
	printf("\n%f\n",f(1.0,3.0));
	
	#if 0 
	while (fgets(buff, sizeof(buff), stdin) != NULL) {
       error = luaL_loadbuffer(L, buff, strlen(buff),"line") || lua_pcall(L, 0, 0, 0);
       if (error) {
			fprintf(stderr, "%s", lua_tostring(L, -1));
			lua_pop(L, 1);/* pop error message from the stack */
		}
		printf("lua >");
		fflush(NULL);
	}
	#endif
	
	lua_close(L);
	return 0;
}

