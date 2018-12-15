[![Build Status](https://travis-ci.org/libretro/vbam-libretro.svg?branch=master)](https://travis-ci.org/libretro/vbam-libretro)
[![Build status](https://ci.appveyor.com/api/projects/status/moh6kxvybt9ey3mp/branch/master?svg=true)](https://ci.appveyor.com/project/bparker06/vbam-libretro/branch/master)

# VisualBoyAdvance-M
Nintendo Game Boy & Game Boy Advance Emulator

# 联机说明

SFML库下载Tag 1.x，有个bug需要修改下，SocketHelper.cpp，Socket::Status SocketHelper::GetErrorStatus()，    
win32下面添加case WSAEISCONN:	   return Socket::Done;      
Andoid下面添加case EISCONN :		return Socket::Done;      

```c++
class ServerInfoDisplay_Imp : public ServerInfoDisplay
{
public:
	void ShowServerIP(sf::IPAddress addr)
	{
		printf("ServerInfoDisplay_Imp ShowServerIP: %s\n", addr.ToString().c_str());
	}
	void ShowConnect(int player)
	{
		printf("ServerInfoDisplay_Imp ShowConnect -->Player %d connected\n", player);
	}
	void Ping()
	{
		//printf("ServerInfoDisplay_Imp Ping\n");
	}
	void Connected()
	{
		printf("ServerInfoDisplay_Imp Connected\n");
	}
};

class ClientInfoDisplay_Imp : public ClientInfoDisplay
{
public:
	void ConnectStart(sf::IPAddress addr)
	{
		printf("ClientInfoDisplay_Imp ConnectStart: %s\n", addr.ToString().c_str());
	}
	void Ping()
	{
		//printf("ClientInfoDisplay_Imp Ping\n");
	}
	void ShowConnect(int player, int togo)
	{
		printf("ClientInfoDisplay_Imp ShowConnect: Connected as Player #%d\n", player);
		if (togo)
			printf("Waiting for %d players to join", togo);
		else
			printf("All players joined.");
	}
	void Connected()
	{
		printf("ClientInfoDisplay_Imp Connected\n");
	}
};

ServerInfoDisplay_Imp server_imp;
ClientInfoDisplay_Imp client_imp;
sf::IPAddress ipAddress = sf::IPAddress("127.0.0.1");

程序初始化时：InitLink();      

模拟器暂停（帧与帧之间）或者模拟器未开始运行时：
服务端： ls.Init(&server_imp);
客户端： lc.Init(ipAddress, &client_imp);

coreloop里面：
if (lanlink.connected && linkid && lc.numtransfers == 0)
			lc.CheckConn();
   
注意：
手机和手机局域网通信：手机开热点后（不要设置密码），IP地址是一个固定的值：192.168.43.1，其他手机将服务端地址设置为192.168.43.1，可以进行局域网通信。

手机和PC局域网通信：PC插在路由器的一个端口上，手机连路由器的wifi，可以进行局域网通信。
```
