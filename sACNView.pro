## Copyright 2016 Tom Barthel-Steer
## http://www.tomsteer.net
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
## http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.

QT       += core gui network multimedia

macx {
    QMAKE_MAC_SDK = macosx10.12
    ICON = res/icon.icns
}

!msvc {
    QMAKE_CXXFLAGS += -std=gnu++0x
}

## External Libs

# Firewall Checker
win32 {
    LIBS += -lole32 -loleaut32
}

#PCap/WinPcap
win32 {
    PCAP_PATH = $${_PRO_FILE_PWD_}/libs/WinPcap-413-173-b4
    contains(QT_ARCH, i386) {
        LIBS += -L$${PCAP_PATH}/lib
    } else {
        LIBS += -L$${PCAP_PATH}/lib/x64
    }
    LIBS += -lwpcap -lPacket
    INCLUDEPATH += $${PCAP_PATH}/Include
}
!win32 {
    LIBS += -lpcap
}

## Main ##

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = sACNView
TEMPLATE = app
DESCRIPTION = $$shell_quote("A tool for sending and receiving the Streaming ACN control protocol")
URL = $$shell_quote("https://docsteer.github.io/sacnview/")
LICENSE = $$shell_quote("Apache 2.0")

INCLUDEPATH += src src/sacn src/sacn/ACNShare

GIT_COMMAND = git --git-dir $$shell_quote($$PWD/.git) --work-tree $$shell_quote($$PWD)
GIT_VERSION = $$system($$GIT_COMMAND describe --always --tags)
GIT_DATE_DAY = $$system($$GIT_COMMAND show -s --date=format:\"%a\" --format=\"%cd\" $$GIT_VERSION)
GIT_DATE_DATE = $$system($$GIT_COMMAND show -s --date=format:\"%d\" --format=\"%cd\" $$GIT_VERSION)
GIT_DATE_MONTH = $$system($$GIT_COMMAND show -s --date=format:\"%b\" --format=\"%cd\" $$GIT_VERSION)
GIT_DATE_YEAR = $$system($$GIT_COMMAND show -s --date=format:\"%Y\" --format=\"%cd\" $$GIT_VERSION)
GIT_TAG = $$system($$GIT_COMMAND describe --abbrev=0 --always --tags)
GIT_SHA1 = $$system($$GIT_COMMAND rev-parse --short HEAD)

DEFINES += GIT_CURRENT_SHA1=\\\"$$GIT_VERSION\\\"
DEFINES += GIT_DATE_DAY=\\\"$$GIT_DATE_DAY\\\"
DEFINES += GIT_DATE_DATE=\\\"$$GIT_DATE_DATE\\\"
DEFINES += GIT_DATE_MONTH=\\\"$$GIT_DATE_MONTH\\\"
DEFINES += GIT_DATE_YEAR=\\\"$$GIT_DATE_YEAR\\\"
lessThan(QT_MAJOR_VERSION, 6):lessThan(QT_MINOR_VERSION, 7) {
    # Windows XP Special Build
    QMAKE_LFLAGS_WINDOWS = /SUBSYSTEM:WINDOWS,5.01
    DEFINES += _ATL_XP_TARGETING
    DEFINES += VERSION=\\\"$$GIT_TAG-WindowsXP\\\"
    TARGET_WINXP = 1
} else {
    DEFINES += VERSION=\\\"$$GIT_TAG\\\"
    TARGET_WINXP = 0
}

SOURCES += src/main.cpp\
    src/mdimainwindow.cpp \
    src/scopewindow.cpp \
    src/universeview.cpp \
    src/sacn/ACNShare/CID.cpp \
    src/sacn/ACNShare/ipaddr.cpp \
    src/sacn/ACNShare/tock.cpp \
    src/sacn/ACNShare/VHD.cpp \
    src/sacn/streamcommon.cpp \
    src/nicselectdialog.cpp \
    src/sacn/streamingacn.cpp \
    src/preferencesdialog.cpp \
    src/preferences.cpp \
    src/sacn/sacnlistener.cpp \
    src/universedisplay.cpp \
    src/transmitwindow.cpp \
    src/sacn/sacnsender.cpp \
    src/configureperchanpriodlg.cpp \
    src/gridwidget.cpp \
    src/priorityeditwidget.cpp \
    src/scopewidget.cpp \
    src/aboutdialog.cpp \
    src/sacn/sacneffectengine.cpp \
    src/mergeduniverselogger.cpp \
    src/sacn/sacnuniverselistmodel.cpp \
    src/snapshot.cpp \
    src/commandline.cpp \
    src/multiuniverse.cpp \
    src/flickerfinderinfoform.cpp \
    src/sacn/sacnsocket.cpp \
    src/logwindow.cpp \
    src/versioncheck.cpp \
    src/sacn/firewallcheck.cpp \
    src/bigdisplay.cpp \
    src/addmultidialog.cpp \
    src/pcapplayback.cpp \
    src/pcapplaybacksender.cpp \
    src/theme/darkstyle.cpp

HEADERS  += src/mdimainwindow.h \
    src/scopewindow.h \
    src/universeview.h \
    src/sacn/ACNShare/CID.h \
    src/sacn/ACNShare/defpack.h \
    src/sacn/ACNShare/ipaddr.h \
    src/sacn/ACNShare/tock.h \
    src/sacn/ACNShare/VHD.h \
    src/sacn/streamcommon.h \
    src/nicselectdialog.h \
    src/sacn/streamingacn.h \
    src/preferencesdialog.h \
    src/preferences.h \
    src/sacn/sacnlistener.h \
    src/universedisplay.h \
    src/transmitwindow.h \
    src/consts.h \
    src/sacn/sacnsender.h \
    src/configureperchanpriodlg.h \
    src/gridwidget.h \
    src/priorityeditwidget.h \
    src/scopewidget.h \
    src/aboutdialog.h \
    src/sacn/sacneffectengine.h \
    src/mergeduniverselogger.h \
    src/sacn/sacnuniverselistmodel.h \
    src/snapshot.h \
    src/commandline.h \
    src/fontdata.h \
    src/multiuniverse.h \
    src/flickerfinderinfoform.h \
    src/sacn/sacnsocket.h \
    src/logwindow.h \
    src/versioncheck.h \
    src/sacn/firewallcheck.h \
    src/bigdisplay.h \ 
    src/addmultidialog.h \
    src/pcapplayback.h \
    src/pcapplaybacksender.h \
    src/ethernetstrut.h \
    src/theme/darkstyle.h

FORMS    += ui/mdimainwindow.ui \
    ui/scopewindow.ui \
    ui/universeview.ui \
    ui/nicselectdialog.ui \
    ui/preferencesdialog.ui \
    ui/transmitwindow.ui \
    ui/configureperchanpriodlg.ui \
    ui/aboutdialog.ui \
    ui/snapshot.ui \
    ui/multiuniverse.ui \
    ui/flickerfinderinfoform.ui \
    ui/logwindow.ui \
    ui/bigdisplay.ui \
    ui/newversiondialog.ui \
    ui/pcapplayback.ui \
    ui/addmultidialog.ui

RESOURCES += \
    res/resources.qrc \
    src/theme/darkstyle.qrc

RC_FILE = res/sacnview.rc

## Deploy ###

isEmpty(TARGET_EXT) {
    win32 {
        TARGET_CUSTOM_EXT = .exe
    }
    macx {
        TARGET_CUSTOM_EXT = .app
    }
} else {
    TARGET_CUSTOM_EXT = $${TARGET_EXT}
}

win32 {
    equals(TARGET_WINXP, "1") {
        PRODUCT_VERSION = "$$GIT_VERSION-WindowsXP"
    } else {
        PRODUCT_VERSION = "$$GIT_VERSION"
    }

    DEPLOY_COMMAND = windeployqt
    DEPLOY_DIR = $$shell_quote($$system_path($${_PRO_FILE_PWD_}/install/deploy))
    DEPLOY_TARGET = $$shell_quote($$system_path($${OUT_PWD}/release/$${TARGET}$${TARGET_CUSTOM_EXT}))
    DEPLOY_OPT = --dir $${DEPLOY_DIR}
    DEPLOY_CLEANUP = $$QMAKE_COPY $${DEPLOY_TARGET} $${DEPLOY_DIR}
    DEPLOY_INSTALLER = makensis /DPRODUCT_VERSION="$${PRODUCT_VERSION}" /DTARGET_WINXP="$${TARGET_WINXP}" $$shell_quote($$system_path($${_PRO_FILE_PWD_}/install/win/install.nsi))

    # WinPCap
    contains(QT_ARCH, i386) {
        PRE_DEPLOY_COMMAND = $$QMAKE_COPY $$system_path($${PCAP_PATH}/Bin/*) $${DEPLOY_DIR}
    } else {
        PRE_DEPLOY_COMMAND = $$QMAKE_COPY $$system_path($${PCAP_PATH}/Bin/x64/*) $${DEPLOY_DIR}
    }
}
macx {
    VERSION = $$system(echo $$GIT_VERSION | sed 's/[a-zA-Z]//')
    DEPLOY_COMMAND = macdeployqt
    DEPLOY_DIR = $${_PRO_FILE_PWD_}/install/mac
    PRE_DEPLOY_COMMAND = $${QMAKE_DEL_FILE} $${DEPLOY_DIR}/sACNView*.dmg
    DEPLOY_TARGET = $${OUT_PWD}/$${TARGET}$${TARGET_CUSTOM_EXT}
    DEPLOY_CLEANUP = $${_PRO_FILE_PWD_}/install/mac/create-dmg --volname "sACNView_Installer" --volicon "$${_PRO_FILE_PWD_}/res/icon.icns"
    DEPLOY_CLEANUP += --background "$${_PRO_FILE_PWD_}/res/mac_install_bg.png" --window-pos 200 120 --window-size 800 400 --icon-size 100 --icon $${TARGET}$${TARGET_CUSTOM_EXT} 200 190 --hide-extension $${TARGET}$${TARGET_CUSTOM_EXT} --app-drop-link 600 185
    DEPLOY_CLEANUP += $${DEPLOY_DIR}/sACNView_$${VERSION}.dmg $${OUT_PWD}/$${TARGET}$${TARGET_CUSTOM_EXT}
}
linux {
    DEB_SANITIZED_VERSION = $$system(echo $$GIT_VERSION | sed 's/[a-zA-Z]//')

    DEPLOY_DIR = $${_PRO_FILE_PWD_}/install/linux
    DEPLOY_TARGET = $${DEPLOY_DIR}/AppDir/$${TARGET}

    DEPLOY_COMMAND = $${OUT_PWD}/linuxdeployqt
    DEPLOY_OPT = -appimage -verbose=2

    PRE_DEPLOY_COMMAND = $${QMAKE_DEL_FILE} $${DEPLOY_DIR}/*.AppImage
    PRE_DEPLOY_COMMAND += && $${QMAKE_DEL_FILE} $${DEPLOY_TARGET}
    PRE_DEPLOY_COMMAND += && wget -c "https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage" -O $${DEPLOY_COMMAND}
    PRE_DEPLOY_COMMAND += && chmod a+x $${DEPLOY_COMMAND}
    PRE_DEPLOY_COMMAND += && unset LD_LIBRARY_PATH
    PRE_DEPLOY_COMMAND += && $$QMAKE_COPY $${OUT_PWD}/$${TARGET} $${DEPLOY_TARGET}
    PRE_DEPLOY_COMMAND += && $$QMAKE_COPY $${DEPLOY_DIR}/usr/share/applications/sacnview.desktop $${DEPLOY_DIR}/AppDir/sacnview.desktop
    PRE_DEPLOY_COMMAND += && $$QMAKE_COPY $${_PRO_FILE_PWD_}/res/Logo.png $${DEPLOY_DIR}/AppDir/sacnview.png

    DEPLOY_CLEANUP = $$QMAKE_COPY $${OUT_PWD}/$${TARGET}*.AppImage $${DEPLOY_DIR}/

    DEPLOY_INSTALLER = $${QMAKE_DEL_FILE} $${DEPLOY_DIR}/*.deb
    DEPLOY_INSTALLER += && $$QMAKE_COPY $${_PRO_FILE_PWD_}/LICENSE $${DEPLOY_DIR}/COPYRIGHT
    DEPLOY_INSTALLER += && $$QMAKE_COPY $${DEPLOY_DIR}/$${TARGET}_$${DEB_SANITIZED_VERSION}.AppImage $${DEPLOY_DIR}/opt/sacnview/sacnview.AppImage
    DEPLOY_INSTALLER += && $$QMAKE_COPY $${_PRO_FILE_PWD_}/res/icon_16.png $${DEPLOY_DIR}/usr/share/icons/hicolor/16x16/apps/sacnview.png
    DEPLOY_INSTALLER += && $$QMAKE_COPY $${_PRO_FILE_PWD_}/res/icon_24.png $${DEPLOY_DIR}/usr/share/icons/hicolor/24x24/apps/sacnview.png
    DEPLOY_INSTALLER += && $$QMAKE_COPY $${_PRO_FILE_PWD_}/res/icon_32.png $${DEPLOY_DIR}/usr/share/icons/hicolor/32x32/apps/sacnview.png
    DEPLOY_INSTALLER += && $$QMAKE_COPY $${_PRO_FILE_PWD_}/res/icon_48.png $${DEPLOY_DIR}/usr/share/icons/hicolor/48x48/apps/sacnview.png
    DEPLOY_INSTALLER += && $$QMAKE_COPY $${_PRO_FILE_PWD_}/res/icon_256.png $${DEPLOY_DIR}/usr/share/icons/hicolor/256x256/apps/sacnview.png
    DEPLOY_INSTALLER += && $$QMAKE_COPY $${_PRO_FILE_PWD_}/res/Logo.png $${DEPLOY_DIR}/usr/share/icons/hicolor/scalable/apps/sacnview.png
    DEPLOY_INSTALLER += && cd $${DEPLOY_DIR}
    DEPLOY_INSTALLER += && fpm -s dir -t deb --deb-meta-file $${DEPLOY_DIR}/COPYRIGHT --license $${LICENSE} --name $${TARGET} --version $${DEB_SANITIZED_VERSION} --description $${DESCRIPTION} --url $${URL} opt/ usr/
}

CONFIG( release , debug | release) {
    QMAKE_POST_LINK += $${PRE_DEPLOY_COMMAND} $$escape_expand(\\n\\t)
    QMAKE_POST_LINK += $${DEPLOY_COMMAND} $${DEPLOY_TARGET} $${DEPLOY_OPT}
    QMAKE_POST_LINK += $$escape_expand(\\n\\t) $${DEPLOY_CLEANUP}
    QMAKE_POST_LINK += $$escape_expand(\\n\\t) $${DEPLOY_INSTALLER}
}
