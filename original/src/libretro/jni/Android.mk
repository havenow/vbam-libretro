LOCAL_PATH := $(call my-dir)

#--------------------sfml-network-------------------------
include $(CLEAR_VARS)

ANDROID_FLAGS := -DANDROID_ARM
LOCAL_ARM_MODE := arm

SRC_DIR			:= ../../../../dependencies/SFML/src/SFML
LOCAL_MODULE    := sfml-network

LOCAL_SRC_FILES = $(SRC_DIR)/Network/Ftp.cpp \
$(SRC_DIR)/Network/Http.cpp \
$(SRC_DIR)/Network/IPAddress.cpp \
$(SRC_DIR)/Network/Packet.cpp \
$(SRC_DIR)/Network/SelectorBase.cpp \
$(SRC_DIR)/Network/SocketTCP.cpp \
$(SRC_DIR)/Network/SocketUDP.cpp \
$(SRC_DIR)/Network/Unix/SocketHelper.cpp \

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../../../dependencies/SFML/include/ \
$(LOCAL_PATH)/../../../../dependencies/SFML/src/

LOCAL_CFLAGS := -O2 -W -Wall -I -DNDEBUG -fexceptions -std=c++11 -pthread
#LOCAL_CFLAGS += -pedantic 发出ANSI C标准所列的全部警告信息

include $(BUILD_STATIC_LIBRARY)
#----------------------------------------------------------

CORE_DIR     := $(LOCAL_PATH)/../..
LIBRETRO_DIR := $(CORE_DIR)/libretro

include $(LIBRETRO_DIR)/Makefile.common

COREFLAGS := -DHAVE_STDINT_H -DLSB_FIRST -D__LIBRETRO__ -DFINAL_VERSION -DC_CORE -DFRONTEND_SUPPORTS_RGB565 -DTILED_RENDERING $(INCFLAGS)


include $(CLEAR_VARS)
LOCAL_MODULE    := retro
LOCAL_CFLAGS += -DANDROID_ARM
LOCAL_ARM_MODE := arm

LOCAL_SRC_FILES := $(SOURCES_CXX) 
LOCAL_CXXFLAGS  := $(COREFLAGS)
LOCAL_LDFLAGS   := -Wl,-version-script=$(LIBRETRO_DIR)/link.T
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../../../dependencies/SFML/include/ \
$(LOCAL_PATH)/../../../../dependencies/SFML/src/

LOCAL_STATIC_LIBRARIES := sfml-network
include $(BUILD_SHARED_LIBRARY)
