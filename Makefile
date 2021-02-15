ifeq ($(BOLOS_SDK),)
$(error Environment variable BOLOS_SDK is not set)
endif
include $(BOLOS_SDK)/Makefile.defines

#Bytecoin /44'/204'
#--path "2147484108/2147483852"
APP_LOAD_PARAMS= --appFlags 0x40 --curve secp256k1 $(COMMON_LOAD_PARAMS)
APPNAME = "Infinium"

ifeq ($(TARGET_NAME),TARGET_BLUE)
ICONNAME = images/icon_bytecoin_blue.gif
else
ICONNAME = images/icon_bytecoin.gif
endif

APPVERSION_M=1
APPVERSION_N=0
APPVERSION_P=1

APPVERSION=$(APPVERSION_M).$(APPVERSION_N).$(APPVERSION_P)
SPECVERSION="Amethyst"

DEFINES   += $(BYTECOIN_CONFIG) BYTECOIN_VERSION=$(APPVERSION) BYTECOIN_NAME=$(APPNAME) BYTECOIN_SPEC_VERSION=$(SPECVERSION)
DEFINES   += BYTECOIN_VERSION_M=$(APPVERSION_M) BYTECOIN_VERSION_N=$(APPVERSION_N) BYTECOIN_VERSION_P=$(APPVERSION_P)


################
# Default rule #
################

all: default

############
# Platform #
############

ifneq ($(NO_CONSENT),)
DEFINES   += NO_CONSENT
endif

DEFINES   += OS_IO_SEPROXYHAL IO_SEPROXYHAL_BUFFER_SIZE_B=128
DEFINES   += HAVE_BAGL HAVE_SPRINTF
#DEFINES   += HAVE_PRINTF PRINTF=screen_printf
DEFINES   += PRINTF\(...\)=
DEFINES   += HAVE_IO_USB HAVE_L4_USBLIB IO_USB_MAX_ENDPOINTS=6 IO_HID_EP_LENGTH=64 HAVE_USB_APDU
#DEFINES  += HAVE_BLE
DEFINES   += UNUSED\(x\)=\(void\)x
DEFINES   += APPVERSION=\"$(APPVERSION)\"
DEFINES   += CUSTOM_IO_APDU_BUFFER_SIZE=\(255+5+64\)
DEFINES   += HAVE_BOLOS_APP_STACK_CANARY
#DEFINES   += BYTECOIN_DEBUG_SEED

#DEFINES   += HAVE_USB_CLASS_CCID


#DEFINES += IOCRYPT
## Debug options
#DEFINES   += DEBUG_HWDEVICE
#DEFINES   += IODUMMYCRYPT
#DEFINES   += IONOCRYPT
#DEFINES   += TESTKEY

DEFINES   += USB_SEGMENT_SIZE=64 
#DEFINES   += U2F_PROXY_MAGIC=\"MOON\"
#DEFINES   += HAVE_IO_U2F HAVE_U2F 

##############
# Compiler #
##############
#GCCPATH   := $(BOLOS_ENV)/gcc-arm-none-eabi-5_3-2016q1/bin/
#CLANGPATH := $(BOLOS_ENV)/clang-arm-fropi/bin/
CC       := $(CLANGPATH)clang 

#CFLAGS   += -O0 -gdwarf-2  -gstrict-dwarf
CFLAGS   += -O3 -Os
#CFLAGS   += -fno-jump-tables -fno-lookup-tables -fsave-optimization-record
#$(info $(CFLAGS))

AS     := $(GCCPATH)arm-none-eabi-gcc

LD       := $(GCCPATH)arm-none-eabi-gcc
#LDFLAGS  += -O0 -gdwarf-2  -gstrict-dwarf
LDFLAGS  += -O3 -Os
LDLIBS   += -lm -lgcc -lc 

# import rules to compile glyphs(/pone)
include $(BOLOS_SDK)/Makefile.glyphs

### variables processed by the common makefile.rules of the SDK to grab source files and include dirs
APP_SOURCE_PATH  += src
#SDK_SOURCE_PATH  += lib_stusb lib_stusb_impl lib_u2f
SDK_SOURCE_PATH  += lib_stusb lib_stusb_impl


load: all
	python -m ledgerblue.loadApp $(APP_LOAD_PARAMS)

delete:
	python -m ledgerblue.deleteApp $(COMMON_DELETE_PARAMS)

# import generic rules from the sdk
include $(BOLOS_SDK)/Makefile.rules

#add dependency on custom makefile filename
dep/%.d: %.c Makefile

